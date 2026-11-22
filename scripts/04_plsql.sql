-- ==============================================================================
-- SCRIPT PL/SQL - OPERACION Y AUDITORIA DE VENTAS
-- Ejecutar despues de 01_ddl.sql y 02_dml.sql.
-- ==============================================================================

-- PROCEDIMIENTO: registra una venta y devuelve el identificador asignado.
-- La secuencia genera la PK; las FK y restricciones de la tabla validan
-- cliente, vehiculo, sucursal, tipo de venta y precio. No confirma la transaccion:
-- el control del COMMIT o ROLLBACK corresponde al usuario que llama al procedimiento.
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

-- FUNCION: informa el estado de la garantia con vencimiento mas reciente
-- del vehiculo consultado. Devuelve SIN GARANTIA cuando no hay cobertura.
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

-- TRIGGER: guarda una copia de los datos esenciales de cada nueva venta.
-- Es de solo insercion; no modifica la venta ni confirma la transaccion.
CREATE OR REPLACE TRIGGER trg_auditar_venta
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    INSERT INTO sales_audit (audit_id, sale_id, sale_date, sale_price)
    VALUES (seq_sales_audit.NEXTVAL, :NEW.sale_id, :NEW.sale_date, :NEW.sale_price);
END;
/
