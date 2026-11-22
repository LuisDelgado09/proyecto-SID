# Proyecto de Bases de Datos Relacionales (SID)

Sistema de concesionaria para gestionar clientes, sucursales, vehiculos,
ventas, seguros, garantias y ordenes de servicio. El modelo entidad-relacion y
relacional se conserva en `docs/modelos/` y el proyecto de Oracle Data Modeler
en `datamodeler/`.

## Integrantes

- Luis Miguel Delgado
- Miguel Angel Blanco
- Samuel Cardoso

## Scripts de entrega

Los scripts estan en `scripts/` y deben ejecutarse en este orden, conectados a
un esquema Oracle vacio:

1. `01_ddl.sql`: crea secuencias, tablas, restricciones, indices y comentarios
   del diccionario de datos.
2. `02_dml.sql`: inserta los datos de prueba (10 ventas, 10 ordenes de servicio
   y 10 garantias, entre otros) y confirma la carga.
3. `03_dql.sql`: ejecuta los reportes de ventas, servicios, garantias y el TOP 5.
4. `04_plsql.sql`: crea el procedimiento `pr_registrar_venta`, la funcion
   `fn_estado_garantia` y el trigger `trg_auditar_venta`.

Los archivos DDL y DML se ejecutan una sola vez en un esquema nuevo; no son
scripts de reinstalacion y fallaran si ya existen los objetos o los datos.
`03_dql.sql` usa `FETCH FIRST`, por lo que requiere Oracle Database 12c o
superior. En SQL Developer se recomienda abrir cada archivo y usar **Run
Script (F5)**, especialmente para compilar los bloques PL/SQL delimitados por
`/`.

## Evidencia y documentacion

- `docs/riesgos-uso-ia-generativa.md`: riesgos y controles para el uso
  profesional de herramientas de IA generativa.
- `docs/modelos/`: versiones del modelo de datos.
- `docs/actas/`: actas de reuniones del equipo.
- `docs/dependencias funcionales/`: dependencias funcionales del modelo.

