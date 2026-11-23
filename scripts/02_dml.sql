-- ==============================================================================
-- SCRIPT DML - INSERCIONES DE PRUEBA
-- Cargue estos datos después de ejecutar 01_ddl.sql.
-- Ejecute una sola vez y use Run Script (F5). Los datos se insertan en orden
-- porque las ventas y órdenes usan clientes, sucursales y vehículos ya creados.
-- ==============================================================================

-- 1. Tipos de venta.
INSERT INTO sale_types (sale_type_id, description) VALUES (seq_sale_types.NEXTVAL, 'Venta Vehículo Nuevo');
INSERT INTO sale_types (sale_type_id, description) VALUES (seq_sale_types.NEXTVAL, 'Venta Vehículo Usado');
INSERT INTO sale_types (sale_type_id, description) VALUES (seq_sale_types.NEXTVAL, 'Venta Flota Corporativa');

-- 2. Sucursales y su tipo.
-- Sucursal Mixta
INSERT INTO branches (branch_id, name, address, city, phone, branch_type)
VALUES ('BR-001', 'Sede Principal Cali', 'Av Pasoancho #80-20', 'Cali', '3100000001', 'MIXED');
INSERT INTO mixed_branches (branch_id) VALUES ('BR-001');

-- Concesionarios exclusivos
INSERT INTO branches (branch_id, name, address, city, phone, branch_type)
VALUES ('BR-002', 'Boutique Norte', 'Calle 70 #10-15', 'Cali', '3100000002', 'DEALERSHIP');
INSERT INTO branches (branch_id, name, address, city, phone, branch_type)
VALUES ('BR-003', 'Showroom El Poblado', 'Cra 43A #1-50', 'Medellín', '3100000003', 'DEALERSHIP');
INSERT INTO dealership_branches (branch_id) VALUES ('BR-002');
INSERT INTO dealership_branches (branch_id) VALUES ('BR-003');

-- Taller exclusivo
INSERT INTO branches (branch_id, name, address, city, phone, branch_type)
VALUES ('BR-004', 'Taller Especializado Sur', 'Cra 100 #11-12', 'Cali', '3100000004', 'WORKSHOP');
INSERT INTO workshop_branches (branch_id) VALUES ('BR-004');

-- 3. Clientes (10 registros).
INSERT INTO customers (customer_id, document_type, document_number, full_name, address, phone, email, registration_date)
VALUES ('C-1001', 'CC', '1100220033', 'Carlos Restrepo', 'Cra 50 # 10-20', '3151112233', 'carlos.r@email.com', TO_DATE('2025-01-15', 'YYYY-MM-DD'));
INSERT INTO customers VALUES ('C-1002', 'CC', '1144556677', 'Ana Maria Valencia', 'Cll 5 # 30-40', '3162223344', 'ana.v@email.com', TO_DATE('2025-03-20', 'YYYY-MM-DD'));
INSERT INTO customers VALUES ('C-1003', 'NIT', '900800700-1', 'Logistica Sur S.A.S', 'Zona Franca Pacifico', '3003334455', 'contacto@logisur.com', TO_DATE('2025-05-10', 'YYYY-MM-DD'));
INSERT INTO customers VALUES ('C-1004', 'CC', '1600700800', 'Jorge Eliecer Gomez', 'Cll 100 # 20-10', '3114445566', 'jorge.g@email.com', TO_DATE('2025-06-12', 'YYYY-MM-DD'));
INSERT INTO customers VALUES ('C-1005', 'CC', '1122334455', 'Sofia Mendoza', 'Av 6N # 40-50', '3125556677', 'sofia.m@email.com', TO_DATE('2025-08-05', 'YYYY-MM-DD'));
INSERT INTO customers VALUES ('C-1006', 'CC', '1199887766', 'Diego Cadavid', 'Cra 80 # 15-20', '3176667788', 'diego.c@email.com', TO_DATE('2025-09-18', 'YYYY-MM-DD'));
INSERT INTO customers VALUES ('C-1007', 'CE', '987654321', 'John Smith', 'Barrio Granada', '3187778899', 'jsmith@email.com', TO_DATE('2025-11-22', 'YYYY-MM-DD'));
INSERT INTO customers VALUES ('C-1008', 'CC', '1155443322', 'Laura Osorio', 'Cll 14 # 50-60', '3198889900', 'laura.o@email.com', TO_DATE('2026-01-10', 'YYYY-MM-DD'));
INSERT INTO customers VALUES ('C-1009', 'NIT', '901234567-8', 'Transportes del Valle', 'Yumbo', '3209990011', 'gerencia@tvalle.com', TO_DATE('2026-02-28', 'YYYY-MM-DD'));
INSERT INTO customers VALUES ('C-1010', 'CC', '1133557799', 'Mauricio Cardenas', 'Ciudad Jardín', '3210001122', 'mauricio.c@email.com', TO_DATE('2026-04-15', 'YYYY-MM-DD'));

-- 4. Vehículos (12 registros).
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VIN11111111111111', 'AAA-111', 'Toyota', 'Corolla', 'Blanco', 'Sedan', 15000);
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VIN22222222222222', 'BBB-222', 'Ford', 'Explorer', 'Negro', 'SUV', 0); -- Nuevo
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VIN33333333333333', 'CCC-333', 'Mazda', 'CX-5', 'Rojo', 'SUV', 35000);
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VIN44444444444444', 'DDD-444', 'Chevrolet', 'Tracker', 'Gris', 'SUV', 0); -- Nuevo
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VIN55555555555555', 'EEE-555', 'Nissan', 'Frontier', 'Blanco', 'Pickup', 45000);
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VIN66666666666666', 'FFF-666', 'Nissan', 'Frontier', 'Blanco', 'Pickup', 50000);
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VIN77777777777777', 'GGG-777', 'Kia', 'Picanto', 'Amarillo', 'Hatchback', 12000);
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VIN88888888888888', 'HHH-888', 'Renault', 'Kwid', 'Azul', 'Hatchback', 0); -- Nuevo
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VIN99999999999999', 'III-999', 'Toyota', 'Prado', 'Plata', 'SUV', 80000);
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VIN00000000000000', 'JJJ-000', 'Ford', 'Ranger', 'Negro', 'Pickup', 0); -- Nuevo
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VINA1A1A1A1A1A1A1', 'KKK-123', 'Mazda', '3', 'Rojo', 'Sedan', 25000);
INSERT INTO vehicles VALUES (seq_vehicles.NEXTVAL, 'VINB2B2B2B2B2B2B2', 'LLL-456', 'Suzuki', 'Swift', 'Blanco', 'Hatchback', 0); -- Nuevo

-- 5. Seguros (8 registros).
INSERT INTO insurances VALUES ('INS-001', 'SURA', 'POL-100200', TO_DATE('2026-01-01','YYYY-MM-DD'), TO_DATE('2026-12-31','YYYY-MM-DD'), 1);
INSERT INTO insurances VALUES ('INS-002', 'Allianz', 'POL-300400', TO_DATE('2026-03-15','YYYY-MM-DD'), TO_DATE('2027-03-14','YYYY-MM-DD'), 2);
INSERT INTO insurances VALUES ('INS-003', 'Mapfre', 'POL-500600', TO_DATE('2025-06-01','YYYY-MM-DD'), TO_DATE('2026-05-31','YYYY-MM-DD'), 3);
INSERT INTO insurances VALUES ('INS-004', 'Bolivar', 'POL-700800', TO_DATE('2026-08-10','YYYY-MM-DD'), TO_DATE('2027-08-09','YYYY-MM-DD'), 4);
INSERT INTO insurances VALUES ('INS-005', 'SURA', 'POL-900100', TO_DATE('2026-02-20','YYYY-MM-DD'), TO_DATE('2027-02-19','YYYY-MM-DD'), 5);
INSERT INTO insurances VALUES ('INS-006', 'Allianz', 'POL-200300', TO_DATE('2026-04-05','YYYY-MM-DD'), TO_DATE('2027-04-04','YYYY-MM-DD'), 7);
INSERT INTO insurances VALUES ('INS-007', 'Mapfre', 'POL-400500', TO_DATE('2026-07-25','YYYY-MM-DD'), TO_DATE('2027-07-24','YYYY-MM-DD'), 9);
INSERT INTO insurances VALUES ('INS-008', 'Bolivar', 'POL-600700', TO_DATE('2026-10-15','YYYY-MM-DD'), TO_DATE('2027-10-14','YYYY-MM-DD'), 11);

-- 6. Garantías (10 registros), algunas vencidas y otras vigentes.
INSERT INTO warranties VALUES ('WAR-001', 'Garantía Extendida', TO_DATE('2025-01-10','YYYY-MM-DD'), TO_DATE('2027-01-09','YYYY-MM-DD'), 'Cobertura motor y transmisión', 1);
INSERT INTO warranties VALUES ('WAR-002', 'Garantía Fábrica', TO_DATE('2026-02-15','YYYY-MM-DD'), TO_DATE('2029-02-14','YYYY-MM-DD'), 'Cobertura total 3 años', 2);
INSERT INTO warranties VALUES ('WAR-003', 'Garantía Básica Usado', TO_DATE('2024-05-20','YYYY-MM-DD'), TO_DATE('2025-05-19','YYYY-MM-DD'), 'VENCIDA - Solo caja', 3);
INSERT INTO warranties VALUES ('WAR-004', 'Garantía Fábrica', TO_DATE('2026-08-01','YYYY-MM-DD'), TO_DATE('2029-07-31','YYYY-MM-DD'), 'Cobertura total 3 años', 4);
INSERT INTO warranties VALUES ('WAR-005', 'Garantía Flota', TO_DATE('2025-03-10','YYYY-MM-DD'), TO_DATE('2026-03-09','YYYY-MM-DD'), 'VENCIDA - Mantenimiento incluido', 5);
INSERT INTO warranties VALUES ('WAR-006', 'Garantía Flota', TO_DATE('2026-04-12','YYYY-MM-DD'), TO_DATE('2027-04-11','YYYY-MM-DD'), 'Mantenimiento incluido', 6);
INSERT INTO warranties VALUES ('WAR-007', 'Garantía Básica Usado', TO_DATE('2026-01-05','YYYY-MM-DD'), TO_DATE('2027-01-04','YYYY-MM-DD'), 'Tren delantero', 7);
INSERT INTO warranties VALUES ('WAR-008', 'Garantía Fábrica', TO_DATE('2026-09-20','YYYY-MM-DD'), TO_DATE('2031-09-19','YYYY-MM-DD'), 'Cobertura total 5 años', 8);
INSERT INTO warranties VALUES ('WAR-009', 'Garantía Extendida', TO_DATE('2025-11-15','YYYY-MM-DD'), TO_DATE('2028-11-14','YYYY-MM-DD'), 'Sistema eléctrico y motor', 9);
INSERT INTO warranties VALUES ('WAR-010', 'Garantía Fábrica', TO_DATE('2026-10-30','YYYY-MM-DD'), TO_DATE('2029-10-29','YYYY-MM-DD'), 'Cobertura total 3 años', 10);

-- 7. Ventas (10 registros para el reporte 1).
-- Usados (Tipo 2) y Nuevos (Tipo 1)
INSERT INTO sales VALUES (seq_sales.NEXTVAL, TO_DATE('2025-02-15','YYYY-MM-DD'), 75000000, 'Crédito', 'C-1001', 1, 'BR-001', 2);
INSERT INTO sales VALUES (seq_sales.NEXTVAL, TO_DATE('2026-03-20','YYYY-MM-DD'), 180000000, 'Contado', 'C-1002', 2, 'BR-002', 1);
INSERT INTO sales VALUES (seq_sales.NEXTVAL, TO_DATE('2025-05-10','YYYY-MM-DD'), 110000000, 'Crédito', 'C-1004', 3, 'BR-001', 2);
INSERT INTO sales VALUES (seq_sales.NEXTVAL, TO_DATE('2026-06-05','YYYY-MM-DD'), 95000000, 'Leasing', 'C-1005', 4, 'BR-003', 1);
INSERT INTO sales VALUES (seq_sales.NEXTVAL, TO_DATE('2025-08-22','YYYY-MM-DD'), 42000000, 'Contado', 'C-1006', 7, 'BR-001', 2);
INSERT INTO sales VALUES (seq_sales.NEXTVAL, TO_DATE('2026-09-10','YYYY-MM-DD'), 58000000, 'Crédito', 'C-1007', 8, 'BR-002', 1);
INSERT INTO sales VALUES (seq_sales.NEXTVAL, TO_DATE('2025-11-05','YYYY-MM-DD'), 210000000, 'Contado', 'C-1008', 9, 'BR-003', 2);
INSERT INTO sales VALUES (seq_sales.NEXTVAL, TO_DATE('2026-10-01','YYYY-MM-DD'), 165000000, 'Crédito', 'C-1010', 10, 'BR-002', 1);
-- Flotas Corporativas (Tipo 3) a Clientes NIT
INSERT INTO sales VALUES (seq_sales.NEXTVAL, TO_DATE('2025-04-12','YYYY-MM-DD'), 125000000, 'Transferencia', 'C-1003', 5, 'BR-001', 3);
INSERT INTO sales VALUES (seq_sales.NEXTVAL, TO_DATE('2026-04-12','YYYY-MM-DD'), 125000000, 'Transferencia', 'C-1009', 6, 'BR-001', 3);

-- 8. Órdenes de servicio (10 registros para el reporte 2).
-- Con seguro (insurance_id no nulo)
INSERT INTO service_orders VALUES ('ORD-001', TO_DATE('2026-07-15','YYYY-MM-DD'), TO_DATE('2026-07-20','YYYY-MM-DD'), 16500, 'Reparación Choque', 'Reemplazo parachoques frontal y pintura', 3500000, 'C-1001', 1, 'BR-004', 'INS-001');
INSERT INTO service_orders VALUES ('ORD-002', TO_DATE('2026-08-10','YYYY-MM-DD'), TO_DATE('2026-08-12','YYYY-MM-DD'), 5000, 'Mantenimiento Preventivo', 'Cambio de aceite y filtros', 450000, 'C-1002', 2, 'BR-001', 'INS-002');
INSERT INTO service_orders VALUES ('ORD-003', TO_DATE('2026-09-05','YYYY-MM-DD'), TO_DATE('2026-09-08','YYYY-MM-DD'), 38000, 'Reparación Motor', 'Fuga de aceite en empaque de culata', 1850000, 'C-1004', 3, 'BR-004', 'INS-003');
INSERT INTO service_orders VALUES ('ORD-004', TO_DATE('2026-10-12','YYYY-MM-DD'), TO_DATE('2026-10-15','YYYY-MM-DD'), 12500, 'Reparación Choque', 'Enderezado de chasis lateral', 5200000, 'C-1006', 7, 'BR-004', 'INS-006');
-- Particulares (insurance_id IS NULL)
INSERT INTO service_orders VALUES ('ORD-005', TO_DATE('2026-02-18','YYYY-MM-DD'), TO_DATE('2026-02-18','YYYY-MM-DD'), 45500, 'Revisión General', 'Alineación y balanceo', 120000, 'C-1003', 5, 'BR-004', NULL);
INSERT INTO service_orders VALUES ('ORD-006', TO_DATE('2026-04-22','YYYY-MM-DD'), TO_DATE('2026-04-24','YYYY-MM-DD'), 51000, 'Mantenimiento Correctivo', 'Cambio pastillas y discos de freno', 850000, 'C-1009', 6, 'BR-001', NULL);
INSERT INTO service_orders VALUES ('ORD-007', TO_DATE('2026-05-30','YYYY-MM-DD'), TO_DATE('2026-06-02','YYYY-MM-DD'), 81000, 'Mantenimiento Correctivo', 'Cambio kit de distribución', 1300000, 'C-1008', 9, 'BR-004', NULL);
INSERT INTO service_orders VALUES ('ORD-008', TO_DATE('2026-11-01','YYYY-MM-DD'), TO_DATE('2026-11-02','YYYY-MM-DD'), 10000, 'Mantenimiento Preventivo', 'Revisión de los 10K kilómetros', 350000, 'C-1005', 4, 'BR-001', NULL);
INSERT INTO service_orders VALUES ('ORD-009', TO_DATE('2026-11-10','YYYY-MM-DD'), TO_DATE('2026-11-11','YYYY-MM-DD'), 25500, 'Revisión Eléctrica', 'Fallo en alternador', 680000, 'C-1010', 11, 'BR-004', NULL);
INSERT INTO service_orders VALUES ('ORD-010', TO_DATE('2026-11-15','YYYY-MM-DD'), NULL, 2000, 'Garantía', 'Ruido anormal en suspensión delantera', 0, 'C-1007', 12, 'BR-001', NULL);

-- Confirma los datos cargados.
COMMIT;