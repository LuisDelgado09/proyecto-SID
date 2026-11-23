-- ==============================================================================
-- SCRIPT DQL - REPORTES DE LA CONCESIONARIA
-- Consultas para los reportes. Ejecute este archivo con Run Script (F5).
-- ==============================================================================

-- Reporte 1: suma las ventas por sucursal, tipo de venta y vehículo.
SELECT
    b.branch_id,
    b.name AS sucursal,
    st.description AS tipo_venta,
    v.vehicle_id,
    v.brand,
    v.model,
    COUNT(s.sale_id) AS numero_ventas,
    SUM(s.sale_price) AS ingresos
FROM sales s
INNER JOIN branches b ON b.branch_id = s.branch_id
INNER JOIN sale_types st ON st.sale_type_id = s.sale_type_id
INNER JOIN vehicles v ON v.vehicle_id = s.vehicle_id
GROUP BY
    b.branch_id, b.name, st.description,
    v.vehicle_id, v.brand, v.model
ORDER BY ingresos DESC, sucursal, v.vehicle_id;

-- Reporte 2: muestra las órdenes con cliente, vehículo y aseguradora.
-- LEFT JOIN permite incluir órdenes que no tienen seguro.
SELECT
    so.order_id,
    so.entry_date,
    so.exit_date,
    c.full_name AS cliente,
    v.brand,
    v.model,
    so.service_type,
    so.diagnosis,
    so.total_cost,
    NVL(i.insurance_company, 'Pago particular / sin aseguradora') AS aseguradora
FROM service_orders so
INNER JOIN customers c ON c.customer_id = so.customer_id
INNER JOIN vehicles v ON v.vehicle_id = so.vehicle_id
LEFT JOIN insurances i ON i.insurance_id = so.insurance_id
ORDER BY so.entry_date, so.order_id;

-- Reporte 3: muestra las garantías y calcula si están vigentes hoy.
SELECT
    w.warranty_id,
    v.vehicle_id,
    v.brand,
    v.model,
    w.warranty_type,
    w.start_date,
    w.end_date,
    CASE
        WHEN TRUNC(SYSDATE) BETWEEN TRUNC(w.start_date) AND TRUNC(w.end_date)
            THEN 'VIGENTE'
        ELSE 'VENCIDA'
    END AS estado_garantia,
    w.terms_conditions
FROM warranties w
INNER JOIN vehicles v ON v.vehicle_id = w.vehicle_id
ORDER BY w.end_date, w.warranty_id;

-- Reporte 4: muestra los cinco vehículos con más kilómetros.
SELECT
    vehicle_id,
    brand,
    model,
    license_plate,
    mileage
FROM vehicles
ORDER BY mileage DESC, vehicle_id
FETCH FIRST 5 ROWS ONLY;
