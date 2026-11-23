-- ==============================================================================
-- Ejecute este archivo con Run Script (F5), después de crear las tablas.
-- ==============================================================================

-- Procedimiento para agregar una venta. Devuelve el ID generado.
-- Si el precio no es mayor que cero, muestra un error.
CREATE OR REPLACE PROCEDURE pr_registrar_venta (
    p_sale_date      IN  DATE,
    p_sale_price     IN  NUMBER,
    p_payment_method IN  VARCHAR2,
    p_customer_id    IN  VARCHAR2,
    p_vehicle_id     IN  INTEGER,
    p_branch_id      IN  VARCHAR2,
    p_sale_type_id   IN  INTEGER,
    p_sale_id        OUT INTEGER
) AS
BEGIN
    IF p_sale_price IS NULL OR p_sale_price <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El precio de venta debe ser mayor que cero.');
    END IF;

    p_sale_id := seq_sales.NEXTVAL;

    INSERT INTO sales (
        sale_id, sale_date, sale_price, payment_method,
        customer_id, vehicle_id, branch_id, sale_type_id
    ) VALUES (
        p_sale_id, p_sale_date, p_sale_price, p_payment_method,
        p_customer_id, p_vehicle_id, p_branch_id, p_sale_type_id
    );
END;
/

-- Función que revisa la garantía con la fecha de vencimiento más lejana.
-- Devuelve VIGENTE, VENCIDA o SIN GARANTIA.
CREATE OR REPLACE FUNCTION fn_estado_garantia (
    p_vehicle_id IN INTEGER
) RETURN VARCHAR2
AS
    v_estado VARCHAR2(20);
BEGIN
    SELECT CASE
               WHEN TRUNC(SYSDATE) BETWEEN TRUNC(start_date) AND TRUNC(end_date)
                   THEN 'VIGENTE'
               ELSE 'VENCIDA'
           END
      INTO v_estado
      FROM (
          SELECT start_date, end_date
            FROM warranties
           WHERE vehicle_id = p_vehicle_id
           ORDER BY end_date DESC, warranty_id DESC
      )
     WHERE ROWNUM = 1;

    RETURN v_estado;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'SIN GARANTIA';
END;
/

-- Trigger que guarda algunos datos cuando se agrega una venta.
CREATE OR REPLACE TRIGGER trg_auditar_venta
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    INSERT INTO sales_audit (audit_id, sale_id, sale_date, sale_price)
    VALUES (seq_sales_audit.NEXTVAL, :NEW.sale_id, :NEW.sale_date, :NEW.sale_price);
END;
/

-- Ejemplo opcional para probar el procedimiento y el trigger.
-- El ROLLBACK evita guardar la venta de prueba.
--
-- DECLARE
--     v_sale_id INTEGER;
-- BEGIN
--     pr_registrar_venta(
--         DATE '2026-11-22', 100000000, 'Prueba',
--         'C-1001', 11, 'BR-001', 1, v_sale_id
--     );
--     DBMS_OUTPUT.PUT_LINE('Venta creada: ' || v_sale_id);
--     ROLLBACK;
-- END;
-- /
--
-- Para revisar si los objetos se crearon correctamente:
-- SELECT object_name, object_type, status
-- FROM user_objects
-- WHERE object_name IN ('PR_REGISTRAR_VENTA', 'FN_ESTADO_GARANTIA',
--                       'TRG_AUDITAR_VENTA')
-- ORDER BY object_type, object_name;
