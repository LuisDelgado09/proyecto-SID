# Riesgos del uso de IA generativa en actividades de bases de datos

En un contexto profesional, las herramientas de IA generativa pueden apoyar la
redaccion de SQL y PL/SQL, pero sus respuestas no sustituyen el criterio ni la
responsabilidad del equipo que diseña, ejecuta y mantiene la base de datos.

| Riesgo | Impacto posible | Medidas de control |
| --- | --- | --- |
| Exposicion de datos | Consultas, esquemas, credenciales o datos personales enviados a un servicio externo pueden quedar fuera del control de la organizacion. | No compartir credenciales ni datos reales; anonimizar ejemplos; usar solo herramientas aprobadas y revisar sus condiciones de tratamiento y retencion. |
| Consultas incorrectas o inventadas | Una respuesta puede usar sintaxis de otro motor, omitir casos limite o producir reportes incorrectos sin errores visibles. | Confirmar el motor/version; revisar el SQL; probar con datos conocidos y comparar totales con fuentes independientes antes de publicar resultados. |
| Cambios destructivos o inseguros | DDL/DML generado puede borrar, alterar o exponer datos, o asignar permisos excesivos. | Revisar cada sentencia; probar en un entorno aislado; aplicar minimo privilegio; exigir respaldos y aprobacion para cambios de produccion. |
| Inyeccion y validacion insuficiente | Codigo sugerido para aplicaciones puede concatenar entradas o no validar parametros, habilitando SQL injection. | Usar consultas parametrizadas, validacion del lado servidor y revision de seguridad antes de integrar codigo. |
| Sesgo y datos sinteticos poco representativos | Datos generados pueden ocultar valores extremos, distribuciones reales o situaciones de grupos especificos. | Documentar que los datos son sinteticos; validar supuestos con responsables del dominio y no usarlos como evidencia de comportamiento real. |
| Falta de trazabilidad y responsabilidad | La procedencia de una consulta o la razon de una decision puede no quedar clara; la organizacion sigue siendo responsable del resultado. | Registrar cambios y revisiones; exigir aprobacion humana; conservar pruebas reproducibles y documentar el uso de IA conforme a las politicas internas. |
| Propiedad intelectual y cumplimiento | Codigo o recomendaciones pueden no ajustarse a licencias, contratos o regulaciones aplicables. | Revisar licencias y politicas institucionales; no incorporar contenido generado sin las verificaciones legales y tecnicas requeridas. |

**Aplicacion a este proyecto:** los scripts contienen datos ficticios. Antes de
ejecutarlos fuera de un entorno academico, un responsable debe verificar la
compatibilidad con la version de Oracle, revisar las restricciones y comprobar
los resultados de cada reporte. Ningun script debe ejecutarse directamente en
produccion sin autorizacion, pruebas, respaldo y control de cambios.
