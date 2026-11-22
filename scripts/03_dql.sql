-- ==============================================================================
-- SCRIPT DQL - REPORTES DE LA CONCESIONARIA
-- Motor: Oracle Database 12c o superior (por FETCH FIRST).
-- Cada consulta tiene su proposito descrito en lenguaje natural.
-- ==============================================================================

-- REPORTE 1: ingresos por sucursal, modalidad de venta y vehiculo.
-- Agrupa las ventas por las dimensiones solicitadas; el identificador de
-- vehiculo conserva los dos Nissan Frontier como vehiculos distintos.
-- Con el conjunto DML incluido, el reporte devuelve 10 vehiculos vendidos.
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

-- REPORTE 2: ordenes de servicio, cliente, vehiculo y cobertura de seguro.
-- El LEFT JOIN conserva tambien las ordenes particulares sin poliza.
-- Las 10 ordenes de prueba aparecen, incluidas las que tienen insurance_id NULL.
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

-- REPORTE 3: detalle de garantias y estado calculado a la fecha de consulta.
-- Lista las 10 garantias cargadas y ordena primero las que vencen antes.
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

-- REPORTE 4 (TOP 5): vehiculos con mayor kilometraje registrado.
-- FETCH FIRST limita el resultado a los cinco registros de mayor kilometraje.
SELECT
    vehicle_id,
    brand,
    model,
    license_plate,
    mileage
FROM vehicles
ORDER BY mileage DESC, vehicle_id
FETCH FIRST 5 ROWS ONLY;
