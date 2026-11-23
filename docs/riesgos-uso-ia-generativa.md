# Riesgos de usar IA en bases de datos

La IA puede ayudar a escribir consultas y código SQL, pero sus respuestas
pueden tener errores. Por eso, una persona del equipo debe revisar y probar
cualquier resultado antes de usarlo.

| Riesgo | Qué puede pasar | Cómo reducirlo |
| --- | --- | --- |
| Exponer información | Se podrían compartir contraseñas o datos personales con un servicio externo. | No enviar contraseñas ni datos reales. Usar ejemplos inventados. |
| Recibir una consulta incorrecta | La IA puede confundir Oracle con otro motor o entregar una consulta que no dé los resultados esperados. | Revisar la consulta y probarla con datos conocidos. |
| Dañar los datos | Un script puede cambiar o borrar información por error. | Probar primero en una base de datos de prueba y revisar cada sentencia antes de ejecutarla. |
| No validar las entradas | El código sugerido podría ser vulnerable a SQL injection. | Usar parámetros en las consultas y revisar cómo se reciben los datos. |
| Usar datos poco realistas | Los datos inventados pueden no representar lo que ocurre en un caso real. | Indicar que son datos de prueba y no usarlos para sacar conclusiones sobre clientes reales. |
| No saber de dónde salió el código | Puede ser difícil explicar quién propuso un cambio o por qué se hizo. | Guardar los cambios y pedir que otra persona del equipo los revise. |

En este proyecto se usan datos ficticios. Antes de ejecutar los scripts, hay
que revisar el orden, confirmar que se está conectado a una base de datos de
prueba y comprobar los resultados.
