-- ==============================================================================
-- SCRIPT DDL - SISTEMA DE CONCESIONARIA
-- Motor: Oracle Database. Ejecutar una sola vez en un esquema vacio.
-- Crea catalogos, entidades, relaciones, restricciones, indices y auditoria.
-- GUIA: en SQL Developer, conectese al esquema de trabajo y ejecute el archivo
-- completo con Run Script (F5). No lo ejecute sobre un esquema que ya tenga
-- estos objetos: no contiene DROP y Oracle avisara que los objetos existen.
-- Al terminar, continúe con 02_dml.sql; este archivo no carga datos de prueba.
-- ==============================================================================

-- 1. SECUENCIAS: asignan consecutivos a tipos de venta, vehiculos, ventas y
-- auditoria. En una instalacion nueva, los datos de prueba empezaran en 1.
CREATE SEQUENCE seq_sale_types START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_vehicles START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sales START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sales_audit START WITH 1 INCREMENT BY 1;

-- 2. TABLAS BASE: primero se crean las entidades sin FK a otras tablas.
-- CLIENTES: personas naturales o juridicas que compran o solicitan servicios.
CREATE TABLE customers (
    customer_id      VARCHAR2(20) NOT NULL,
    document_type    VARCHAR2(10) NOT NULL, -- Ej: 'CC', 'NIT', 'CE'
    document_number  VARCHAR2(30) NOT NULL,
    full_name        VARCHAR2(120) NOT NULL,
    address          VARCHAR2(150),
    phone            VARCHAR2(20),
    email            VARCHAR2(100),
    registration_date DATE,
    CONSTRAINT pk_customers PRIMARY KEY (customer_id),
    CONSTRAINT uq_customer_doc UNIQUE (document_type, document_number)
);

-- TIPOS DE VENTA: catalogo que clasifica ventas individuales o corporativas.
CREATE TABLE sale_types (
    sale_type_id     INTEGER NOT NULL,
    description      VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_sale_types PRIMARY KEY (sale_type_id)
);

-- SUCURSALES: entidad general; branch_type indica el subtipo correspondiente.
CREATE TABLE branches (
    branch_id        VARCHAR2(10) NOT NULL,
    name             VARCHAR2(100) NOT NULL,
    address          VARCHAR2(150),
    city             VARCHAR2(60),
    phone            VARCHAR2(20),
    branch_type      VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_branches PRIMARY KEY (branch_id),
    CONSTRAINT chk_branch_type CHECK (branch_type IN ('MIXED', 'DEALERSHIP', 'WORKSHOP'))
);

-- 3. SUBTIPOS de sucursal: cada PK tambien es FK a branches. Esto evita crear
-- un subtipo sin su sucursal padre; branch_type registra la categoria general.
CREATE TABLE mixed_branches (
    branch_id        VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_mixed_branches PRIMARY KEY (branch_id),
    CONSTRAINT fk_mixed_branch FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE dealership_branches (
    branch_id        VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_dealership_branches PRIMARY KEY (branch_id),
    CONSTRAINT fk_dealership_branch FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE workshop_branches (
    branch_id        VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_workshop_branches PRIMARY KEY (branch_id),
    CONSTRAINT fk_workshop_branch FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- 4. TABLAS OPERATIVAS: se crean despues de sus padres para poder declarar FKs.
-- VEHICULOS: inventario identificado por VIN y placa.
CREATE TABLE vehicles (
    vehicle_id       INTEGER NOT NULL,
    vin              VARCHAR2(17) NOT NULL,
    license_plate    VARCHAR2(10),
    brand            VARCHAR2(50) NOT NULL,
    model            VARCHAR2(50) NOT NULL,
    color            VARCHAR2(30),
    vehicle_type     VARCHAR2(30), -- Ej: 'SUV', 'Sedan', 'Pickup'
    mileage          INTEGER,
    CONSTRAINT pk_vehicles PRIMARY KEY (vehicle_id),
    CONSTRAINT uq_vehicle_vin UNIQUE (vin),
    CONSTRAINT uq_vehicle_plate UNIQUE (license_plate),
    CONSTRAINT chk_vehicle_mileage CHECK (mileage IS NULL OR mileage >= 0)
);

-- SEGUROS: polizas asociadas al vehiculo asegurado.
CREATE TABLE insurances (
    insurance_id     VARCHAR2(20) NOT NULL,
    insurance_company VARCHAR2(100) NOT NULL,
    policy_number    VARCHAR2(50) NOT NULL,
    start_date       DATE NOT NULL,
    end_date         DATE NOT NULL,
    vehicle_id       INTEGER NOT NULL,
    CONSTRAINT pk_insurances PRIMARY KEY (insurance_id),
    CONSTRAINT uq_insurance_policy UNIQUE (insurance_company, policy_number),
    CONSTRAINT fk_insurances_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    CONSTRAINT chk_insurance_dates CHECK (end_date >= start_date)
);
CREATE INDEX idx_insurances_veh ON insurances(vehicle_id);

-- GARANTIAS: cobertura y condiciones asociadas a un vehiculo.
CREATE TABLE warranties (
    warranty_id      VARCHAR2(20) NOT NULL,
    warranty_type    VARCHAR2(50) NOT NULL,
    start_date       DATE NOT NULL,
    end_date         DATE NOT NULL,
    terms_conditions CLOB,
    vehicle_id       INTEGER NOT NULL,
    CONSTRAINT pk_warranties PRIMARY KEY (warranty_id),
    CONSTRAINT fk_warranties_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    CONSTRAINT chk_warranty_dates CHECK (end_date >= start_date)
);
CREATE INDEX idx_warranties_veh ON warranties(vehicle_id);

-- VENTAS: transacciones entre un cliente y una sucursal para un vehiculo.
CREATE TABLE sales (
    sale_id          INTEGER NOT NULL,
    sale_date        DATE NOT NULL,
    sale_price       NUMBER(12,2) NOT NULL,
    payment_method   VARCHAR2(30),
    customer_id      VARCHAR2(20) NOT NULL,
    vehicle_id       INTEGER NOT NULL,
    branch_id        VARCHAR2(10) NOT NULL,
    sale_type_id     INTEGER NOT NULL,
    CONSTRAINT pk_sales PRIMARY KEY (sale_id),
    CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_sales_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    CONSTRAINT fk_sales_branch FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    CONSTRAINT fk_sales_sale_type FOREIGN KEY (sale_type_id) REFERENCES sale_types(sale_type_id),
    CONSTRAINT chk_sales_price CHECK (sale_price > 0)
);
CREATE INDEX idx_sales_customer ON sales(customer_id);
CREATE INDEX idx_sales_vehicle ON sales(vehicle_id);
CREATE INDEX idx_sales_branch ON sales(branch_id);
CREATE INDEX idx_sales_sale_type ON sales(sale_type_id);

-- AUDITORIA DE VENTAS: conserva los datos de ventas insertadas mediante el trigger.
-- No tiene FK a sales para preservar el historial ante cambios futuros en ventas.
CREATE TABLE sales_audit (
    audit_id         INTEGER NOT NULL,
    sale_id          INTEGER NOT NULL,
    sale_date        DATE NOT NULL,
    sale_price       NUMBER(12,2) NOT NULL,
    audited_at       TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_sales_audit PRIMARY KEY (audit_id)
);

-- ORDENES DE SERVICIO: diagnostico, costos y atencion del vehiculo.
CREATE TABLE service_orders (
    order_id         VARCHAR2(20) NOT NULL,
    entry_date       DATE NOT NULL,
    exit_date        DATE,
    entry_mileage    INTEGER NOT NULL,
    service_type     VARCHAR2(50) NOT NULL, -- Ej: 'Mantenimiento Preventivo', 'Correctivo'
    diagnosis        CLOB,
    total_cost       NUMBER(12,2) NOT NULL,
    customer_id      VARCHAR2(20) NOT NULL,
    vehicle_id       INTEGER NOT NULL,
    branch_id        VARCHAR2(10) NOT NULL,
    insurance_id     VARCHAR2(20), -- Opcional (NULL) si no ingresa por seguro
    CONSTRAINT pk_service_orders PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_orders_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    CONSTRAINT fk_orders_branch FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    CONSTRAINT fk_orders_insurance FOREIGN KEY (insurance_id) REFERENCES insurances(insurance_id),
    CONSTRAINT chk_order_mileage CHECK (entry_mileage >= 0),
    CONSTRAINT chk_order_cost CHECK (total_cost >= 0),
    CONSTRAINT chk_order_dates CHECK (exit_date IS NULL OR exit_date >= entry_date)
);
CREATE INDEX idx_orders_customer ON service_orders(customer_id);
CREATE INDEX idx_orders_vehicle ON service_orders(vehicle_id);
CREATE INDEX idx_orders_branch ON service_orders(branch_id);
CREATE INDEX idx_orders_insurance ON service_orders(insurance_id);

-- 5. DICCIONARIO DE DATOS: estos comentarios se pueden consultar desde las
-- propiedades de tablas/columnas en SQL Developer o en USER_TAB_COMMENTS.
COMMENT ON TABLE customers IS 'Clientes naturales o juridicos de la concesionaria.';
COMMENT ON TABLE sale_types IS 'Catalogo de modalidades de venta.';
COMMENT ON TABLE branches IS 'Sucursales y tipo de operacion.';
COMMENT ON TABLE mixed_branches IS 'Subtipo de sucursal mixta.';
COMMENT ON TABLE dealership_branches IS 'Subtipo de sucursal concesionario.';
COMMENT ON TABLE workshop_branches IS 'Subtipo de sucursal taller.';
COMMENT ON TABLE vehicles IS 'Vehiculos del inventario, vendidos o atendidos.';
COMMENT ON TABLE insurances IS 'Polizas de seguro asociadas a vehiculos.';
COMMENT ON TABLE warranties IS 'Garantias y condiciones asociadas a vehiculos.';
COMMENT ON TABLE sales IS 'Ventas de vehiculos a clientes en sucursales.';
COMMENT ON TABLE sales_audit IS 'Historial de insercion de ventas generado por el trigger.';
COMMENT ON TABLE service_orders IS 'Ordenes de servicio, con seguro opcional.';

COMMENT ON COLUMN branches.branch_type IS 'Valores permitidos: MIXED, DEALERSHIP o WORKSHOP.';
COMMENT ON COLUMN service_orders.insurance_id IS 'Poliza que cubre el servicio; NULL indica atencion particular.';
COMMENT ON COLUMN service_orders.exit_date IS 'Fecha de salida; NULL indica que la orden sigue abierta.';