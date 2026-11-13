# Informe de análisis — Auditoría de Datos en EduTrack

> Estado actual: Q1–Q12 fueron ejecutadas en Supabase y los resultados se comunicaron por el estudiante. Q1–Q5 corresponden al estado anterior a Q6–Q8; Q9–Q12 reflejan el estado posterior a la limpieza. No se adjuntaron capturas/exportaciones de Supabase al repositorio.

## Resumen ejecutivo

La base original importada contenía 17 matrículas (`enrollments`). Q6 agregó una matrícula (ID 18), Q7 corrigió 2 instructores NULL y Q8 eliminó 2 matrículas de cuentas de prueba; el estado final reportado es de 16 matrículas. Q9 encontró 4 categorías. Q12 suma 819.84 en los valores registrados en `monthly_fee_paid`; esto es una suma de importes mensuales almacenados, no una métrica de ingresos recurrentes reales verificada. Según Q10, UI/UX Fundamentals tuvo el menor promedio de completion (0.00%) e Intro to Python el mayor (80.00%). Los resultados son los comunicados del entorno Supabase y no se adjuntaron capturas/exportaciones locales.

**Recomendaciones operativas:** mantener prechecks y postchecks para toda mutación; evitar reejecutar Q6–Q8 en la base actual; verificar/ajustar la secuencia SERIAL antes de futuras inserciones con ID generado, ya que Q6 suministró explícitamente ID 18; aclarar la semántica y período cubierto por `monthly_fee_paid` antes de presentar sumas como métricas financieras.

## Inicialización y verificación de la base de datos

- **Estado de importación:** PASS — el estudiante confirma que el dataset oficial original se importó correctamente en Supabase.
- **Conteos verificados:**

| Tabla | Filas reportadas en Supabase | Esperadas en el dataset original | Estado |
|---|---:|---:|---|
| `students` | 10 | 10 | PASS |
| `courses` | 7 | 7 | PASS |
| `enrollments` | 17 | 17 | PASS |

- **Modificaciones posteriores:** Q6 agregó ID 18 (conteo 18), Q7 actualizó 2 instructores y Q8 eliminó 2 cuentas de prueba (conteo final 16), según resultados comunicados. Q1–Q5 son pre-mutación; Q9–Q12 reflejan el estado post-limpieza. El reporte de resultados no implica que las consultas se hayan reejecutado durante esta actualización.
- **Evidencia disponible:** resultados comunicados por el estudiante; las capturas de Supabase fueron revisadas en la conversación, pero no se incorporaron al repositorio local.

## Q1 — Inscripciones en 'Intro to Python'
- **Objetivo:** Listar todas las inscripciones de `'Intro to Python'` mostrando nombre, email y porcentaje de completado.
- **Estado de ejecución SQL:** PASS — consulta facilitada por el estudiante y confirmada como ejecutada correctamente en Supabase.
- **Resultado real:** 5 filas.
  - Emily Watson — `emily.watson@student.edutrack.com` — 85%
  - Klaus Weber — `klaus.weber@student.edutrack.com` — 92%
  - Marco Rossi — `marco.rossi@student.edutrack.com` — 88%
  - James Miller — `james.miller@test.com` — 30%
  - Priya Sharma — `priya.sharma@student.edutrack.com` — 55%
- **Filas afectadas:** 0 (SELECT).
- **Observaciones:** Este resultado se obtuvo antes de Q8 e incluye la cuenta de prueba `@test.com`, posteriormente eliminada. Q1–Q5 documentan el estado pre-limpieza.
- **Evidencia:** Resultado confirmado en el mensaje del estudiante; no se adjuntó captura/exportación de Supabase al repositorio.
- **Evaluación:** PASS (evidencia comunicada; evidencia visual no adjunta).

## Q2 — Completion below 10 percent
- **Objetivo:** Obtener matrículas con `completion_percentage < 10`.
- **Estado de ejecución SQL:** PASS — consulta facilitada por el estudiante y confirmada como ejecutada correctamente en Supabase.
- **Resultado real:** 4 filas.
  - Yuki Nakamura — UI/UX Fundamentals — 0%
  - Pierre Dubois — UI/UX Fundamentals — 0%
  - Lucia Fernandes — Digital Marketing 101 — 3%
  - Lucia Fernandes — Web Design Basics — 5%
- **Filas afectadas:** 0 (SELECT).
- **Observaciones:** Orden ascendente por porcentaje, según SQL y salida reportados.
- **Evidencia:** Resultado confirmado en el mensaje del estudiante; no se adjuntó captura/exportación de Supabase al repositorio.
- **Evaluación:** PASS (evidencia comunicada; evidencia visual no adjunta).

## Q3 — Missing instructors
- **Objetivo:** Encontrar inscripciones con `instructor` NULL.
- **Estado de ejecución SQL:** PASS — consulta facilitada por el estudiante y confirmada como ejecutada correctamente en Supabase.
- **Resultado real:** 2 filas.
  - ID 10 — Yuki Nakamura — UI/UX Fundamentals — NULL
  - ID 11 — Pierre Dubois — UI/UX Fundamentals — NULL
- **Filas afectadas:** 0 (SELECT).
- **Observaciones:** `IS NULL` selecciona los dos valores faltantes reportados; salida ordenada por `id`.
- **Evidencia:** Resultado confirmado en el mensaje del estudiante; no se adjuntó captura/exportación de Supabase al repositorio.
- **Evaluación:** PASS (evidencia comunicada; evidencia visual no adjunta).

## Q4 — Top five incomplete passes
- **Objetivo:** Listar las 5 matrículas no aprobadas con mayor porcentaje de completado.
- **Estado de ejecución SQL:** PASS — consulta facilitada por el estudiante y confirmada como ejecutada correctamente en Supabase.
- **Resultado real:** 5 filas.
  - Emily Watson — Web Design Basics — 60% — `passed = false`
  - Priya Sharma — Intro to Python — 55% — `passed = false`
  - Yuki Nakamura — Data Analysis with SQL — 45% — `passed = false`
  - Emily Watson — Advanced Python — 40% — `passed = false`
  - James Miller — Intro to Python — 30% — `passed = false`
- **Filas afectadas:** 0 (SELECT).
- **Observaciones:** Filtro de reprobados, orden descendente y límite de cinco coinciden con la consulta reportada.
- **Evidencia:** Resultado confirmado en el mensaje del estudiante; no se adjuntó captura/exportación de Supabase al repositorio.
- **Evaluación:** PASS (evidencia comunicada; evidencia visual no adjunta).

## Q5 — Enrollments from July 1, 2024
- **Objetivo:** Mostrar inscripciones desde el 1 de julio de 2024 en orden descendente de fecha.
- **Estado de ejecución SQL:** PASS — consulta facilitada por el estudiante y confirmada como ejecutada correctamente en Supabase.
- **Resultado real:** 9 filas.
  - ID 17 — Emily Watson — 2025-03-05
  - ID 16 — Pierre Dubois — 2025-02-20
  - ID 15 — Priya Sharma — 2025-01-10
  - ID 12 — Priya Sharma — 2024-12-01
  - ID 11 — Pierre Dubois — 2024-11-05
  - ID 10 — Yuki Nakamura — 2024-10-11
  - ID 9 — Yuki Nakamura — 2024-09-03
  - ID 8 — Marco Rossi — 2024-08-09
  - ID 6 — Lucia Fernandes — 2024-07-01
- **Filas afectadas:** 0 (SELECT).
- **Observaciones:** El límite incluye el propio 2024-07-01; filas ordenadas por fecha descendente.
- **Evidencia:** Resultado confirmado en el mensaje del estudiante; no se adjuntó captura/exportación de Supabase al repositorio.
- **Evaluación:** PASS (evidencia comunicada; evidencia visual no adjunta).

## Q6 — Insert missing enrollment
- **Objetivo:** Insertar la matrícula faltante descrita en el dataset oficial.
- **Estado de ejecución SQL:** PASS — el estudiante confirma que ejecutó el INSERT en Supabase; no se reejecutó durante la documentación.
- **Precheck real:** conteo inicial de `enrollments` = 17; ID 18 existente = 0; matrícula equivalente con `student_id = 3` y `course_id = 5` = 0.
- **Resultado real:** INSERT devolvió exactamente una fila (ID 18) con `student_id = 3`, Lucia Fernandes, `lucia.fernandes@student.edutrack.com`, `course_id = 5`, Advanced Python, Programming, `enrollment_date = 2025-04-01`, `completion_percentage = 0`, `passed = false`, `monthly_fee_paid = 69.99`, instructor Carlos Vega.
- **Filas afectadas:** 1 insertada.
- **Postcheck real:** ID 18 verificado con los valores esperados; conteo final de `enrollments` = 18 (incremento exacto de una fila).
- **Observaciones:** No se modificaron `students` ni `courses`. Q7 y Q8 se ejecutaron después de Q6 según los resultados comunicados.
- **Evidencia:** Valores de precheck, `RETURNING *` y conteo final comunicados por el estudiante. No se adjuntó captura/exportación de Supabase al repositorio.
- **Evaluación:** PASS (resultados comunicados; evidencia visual no adjunta).

## Q7 — Completar instructores NULL
- **Objetivo:** Asignar `'Pending assignment'` a todas las matrículas cuyo instructor era NULL.
- **Estado de ejecución SQL:** PASS — statement ejecutado en Supabase según confirmación del estudiante; no se reejecutó durante esta actualización documental.
- **Precheck real:** 2 filas objetivo: ID 10, Yuki Nakamura; ID 11, Pierre Dubois. Ambos tenían `instructor IS NULL`.
- **SQL ejecutado:** `UPDATE enrollments SET instructor = 'Pending assignment' WHERE instructor IS NULL RETURNING id, student_name, course_title, instructor;`
- **Resultado real:** 2 registros actualizados: IDs 10 y 11; ambos instructores quedaron como `Pending assignment`.
- **Filas afectadas:** 2 actualizadas.
- **Postcheck real:** `missing_instructors = 0`; `corrected_records = 2`; `total_enrollments = 18`.
- **Observaciones:** Se actualizó únicamente el conjunto preinspeccionado por la condición `instructor IS NULL`, según los datos reportados.
- **Evidencia:** Precheck, salida `RETURNING` y postcheck comunicados por el estudiante. No se adjuntó captura/exportación al repositorio.
- **Evaluación:** PASS (resultados comunicados; evidencia visual no adjunta).

## Q8 — Eliminar matrículas de cuentas de prueba
- **Objetivo:** Eliminar las matrículas cuyo email de cuenta de prueba termina en `@test.com`.
- **Estado de ejecución SQL:** PASS — statement ejecutado en Supabase según confirmación del estudiante; no se reejecutó durante esta actualización documental.
- **Precheck real:** ID 13, James Miller (`james.miller@test.com`), fee $49.99; ID 14, Alex Chen (`alex.chen@test.com`), fee $39.99.
- **SQL ejecutado:** `DELETE FROM enrollments WHERE student_email LIKE '%@test.com' RETURNING id, student_name, student_email, course_title, monthly_fee_paid;`
- **Resultado real:** 2 registros eliminados, IDs 13 y 14; suma de `monthly_fee_paid` eliminada = $89.98.
- **Filas afectadas:** 2 eliminadas.
- **Postcheck real:** `total_enrollments = 16`; `remaining_test_accounts = 0`; `remaining_deleted_ids = 0`.
- **Observaciones:** El resultado Q8 es posterior al Q7 y al Q6; no se ejecutaron mutaciones adicionales al documentarlo.
- **Evidencia:** Precheck, salida `RETURNING` y postcheck comunicados por el estudiante. No se adjuntó captura/exportación al repositorio.
- **Evaluación:** PASS (resultados comunicados; evidencia visual no adjunta).

## Q9 — Enrollment count by category
- **Objetivo:** Contar matrículas por `category` después de completar Q6–Q8.
- **Estado de ejecución SQL:** PASS — consulta ejecutada y resultado comunicado por el estudiante.
- **SQL ejecutado:** `SELECT category, COUNT(*) AS total_enrollments FROM enrollments GROUP BY category ORDER BY total_enrollments DESC;`
- **Resultado real:** 4 grupos: Programming 7; Design 4; Data 3; Marketing 2.
- **Total comprobado:** 16 matrículas, consistente con el postcheck de Q8.
- **Filas devueltas:** 4 (una por categoría); filas afectadas: 0.
- **Observaciones:** Agregación post-limpieza; total y categorías según resultados comunicados.
- **Evidencia:** Resultados comunicados en la conversación; captura/exportación no incorporada al repositorio.
- **Evaluación:** PASS.

## Q10 — Average completion by course
- **Objetivo:** Calcular el promedio de `completion_percentage` por curso y ordenar de menor a mayor.
- **Estado de ejecución SQL:** PASS — consulta ejecutada y resultado comunicado por el estudiante.
- **SQL ejecutado:** `SELECT course_title, ROUND(AVG(completion_percentage), 2) AS average_completion FROM enrollments GROUP BY course_title ORDER BY average_completion ASC;`
- **Resultado real:** UI/UX Fundamentals 0.00%; Web Design Basics 32.50%; Digital Marketing 101 36.50%; Advanced Python 45.00%; Data Analysis with SQL 47.67%; Intro to Python 80.00%.
- **Filas devueltas:** 6 (una por curso con matrículas); filas afectadas: 0.
- **Observaciones:** UI/UX Fundamentals es el menor promedio; Intro to Python es el mayor. Resultados del estado post-limpieza.
- **Evidencia:** Resultados comunicados en la conversación; captura/exportación no incorporada al repositorio.
- **Evaluación:** PASS.

## Q11 — Courses with more than three enrollments
- **Objetivo:** Mostrar cursos con más de 3 matrículas usando `HAVING`.
- **Estado de ejecución SQL:** PASS — consulta ejecutada y resultado comunicado por el estudiante.
- **SQL ejecutado:** `SELECT course_title, COUNT(*) AS total_enrollments FROM enrollments GROUP BY course_title HAVING COUNT(*) > 3 ORDER BY total_enrollments DESC;`
- **Resultado real:** Intro to Python — 4 matrículas.
- **Filas devueltas:** 1; filas afectadas: 0.
- **Observaciones:** `HAVING COUNT(*) > 3` filtra grupos agregados; resultado del estado post-limpieza.
- **Evidencia:** Resultado comunicado en la conversación; captura/exportación no incorporada al repositorio.
- **Evaluación:** PASS.

## Q12 — Revenue by category
- **Objetivo:** Sumar `monthly_fee_paid` por categoría, ordenado de mayor a menor.
- **Estado de ejecución SQL:** PASS — consulta ejecutada y resultado comunicado por el estudiante.
- **SQL ejecutado:** `SELECT category, ROUND(SUM(monthly_fee_paid), 2) AS total_revenue FROM enrollments GROUP BY category ORDER BY total_revenue DESC;`
- **Resultado real:** Programming 409.93; Data 179.97; Design 169.96; Marketing 59.98. Total sumado: 819.84.
- **Filas devueltas:** 4 (una por categoría); filas afectadas: 0.
- **Observaciones:** Son sumas de los valores registrados en `monthly_fee_paid`, no ingresos recurrentes ni resultados financieros auditados. Estado post-limpieza.
- **Evidencia:** Resultados comunicados en la conversación; captura/exportación no incorporada al repositorio.
- **Evaluación:** PASS.

## Hallazgos de calidad de datos y recomendaciones
- En el estado inicial se reportaron 2 instructores NULL; Q7 corrigió ambos a `Pending assignment` y el postcheck reportó cero faltantes.
- Q8 retiró dos matrículas de cuentas de prueba `@test.com`; el postcheck reportó cero cuentas restantes y 16 matrículas en total.
- Las consultas Q1–Q5 describen el estado pre-limpieza; los resultados Q9–Q12 reflejan las mutaciones ya aplicadas. No comparar esos grupos como si correspondieran a una única fotografía de la base.
- El total 819.84 es una suma de importes de `monthly_fee_paid` registrados por matrícula. No es una métrica de ingresos recurrentes ni evidencia de ingresos reales de producción.
- Antes de nuevos INSERT con ID generado, sincronizar la secuencia SERIAL de `enrollments` con el máximo ID existente. El dataset y Q6 suministran IDs explícitos; PostgreSQL no avanza automáticamente la secuencia por esos valores. Un ejemplo de sincronización futura, **documentado pero no ejecutado**, es:
  `SELECT setval(pg_get_serial_sequence('public.enrollments', 'id'), (SELECT MAX(id) FROM public.enrollments), true);`
- Mantener prechecks/postchecks y revisar el alcance de cuentas de prueba antes de operaciones destructivas.

## Evidencia y validación
- Dataset oficial: descargado como `edutrack.sql` desde la fuente oficial; hash y esquema registrados en `docs/VALIDATION.md`.
- Requisitos y criterios oficiales: consultados y registrados en `docs/VALIDATION.md`.
- Importación Supabase y conteos iniciales: confirmados; ver sección de inicialización arriba.
- Q1–Q12: consultas y resultados comunicados por el estudiante; las capturas de Supabase fueron revisadas en la conversación, pero no se añadieron al repositorio local.
- Q6–Q8: prechecks, SQL/filas afectadas y postchecks comunicados por el estudiante y documentados arriba. No se reejecutaron mutaciones durante la documentación.
- El README oficial no enumera una checklist independiente numerada de 24 tareas. Los 24 controles transparentes derivados y los 8 criterios oficiales están evaluados por separado en `docs/VALIDATION.md`.
- Escaneo local de patrones comunes de credenciales: sin hallazgos de secretos; ver límites en `docs/VALIDATION.md`.
