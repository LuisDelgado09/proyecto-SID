# Proyecto SID: base de datos de una concesionaria

Este proyecto organiza la información de clientes, sucursales, vehículos,
ventas, seguros, garantías y órdenes de servicio. Los modelos y actas del
trabajo están en la carpeta `docs/`. El modelo de Oracle Data Modeler está en
`datamodeler/`.

## Integrantes

- Luis Miguel Delgado
- Miguel Angel Blanco
- Samuel Cardoso

## Scripts de entrega

Los archivos SQL están en `scripts/`. Para probarlos, conéctate a un esquema
Oracle vacío y ejecútalos en este orden:

1. `01_ddl.sql` crea las tablas y sus relaciones.
2. `02_dml.sql` agrega los datos de prueba. Hay 10 ventas, 10 órdenes de
   servicio y 10 garantías.
3. `03_dql.sql` contiene los reportes de ventas, servicios, garantías y el TOP 5.
4. `04_plsql.sql` crea un procedimiento, una función y un trigger.

Los dos primeros scripts se deben ejecutar una sola vez: si las tablas o los
datos ya existen, se producirán errores. En SQL Developer usa **Run Script
(F5)** para cada archivo. El reporte TOP 5 necesita Oracle 12c o una versión
más reciente.

## Archivos de apoyo

- `docs/riesgos-uso-ia-generativa.md` resume riesgos de usar IA para trabajar
  con bases de datos.
- `docs/modelos/` contiene las versiones de los modelos.
- `docs/actas/` contiene las actas de reunión.
- `docs/dependencias funcionales/` contiene las dependencias funcionales.

