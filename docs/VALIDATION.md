# Validación oficial — Auditoría de Datos en EduTrack

## Fuentes verificadas

- Requisitos: [README.es.md oficial](https://github.com/4GeeksAcademy/ai-engineering-syllabus/blob/main/content/projects/edutrack-data-audit-sql/README.es.md), rama `main`, consultado el 2026-11-13.
- Dataset original: [edutrack.sql oficial](https://raw.githubusercontent.com/4GeeksAcademy/ai-engineering-syllabus/refs/heads/main/content/projects/edutrack-data-audit-sql/edutrack.sql), descargado sin modificaciones. SHA-256: `faebf83f72bbf95d7ef55aad78f36fc9168891c36e8994eeb4a65629086e3387`.

**Nota sobre el conteo de checklist:** el README oficial contiene requisitos, pero no publica una lista numerada de exactamente 24 tareas. La tabla siguiente ofrece 24 controles de auditoría desglosados de las frases/requisitos publicados; no se presenta como una checklist oficial numerada. Los requisitos no desglosables se conservan en su redacción de origen. El texto oficial y los 8 criterios se verificaron en la fuente.

## 24 controles de validación derivados del texto oficial

| # | Requisito oficial / control verificable | Estado | Evidencia / motivo |
|---:|---|---|---|
| 1 | Importar `edutrack.sql` en un proyecto de Supabase correctamente | PASS | El estudiante confirma importación exitosa del dataset original; conteos verificados: 10 students, 7 courses, 17 enrollments. No se adjuntó captura/export de Supabase al workspace. |
| 2 | Verificar que la tabla `enrollments` existe y contiene datos | PASS | Resultado Supabase confirmado por el estudiante: 17 filas; esperado según dataset original: 17. Evidencia visual/export no adjunta. |
| 3 | Verificar que la tabla `students` existe y contiene datos | PASS | Resultado Supabase confirmado por el estudiante: 10 filas; esperado según dataset original: 10. Evidencia visual/export no adjunta. |
| 4 | Verificar que la tabla `courses` existe y contiene datos | PASS | Resultado Supabase confirmado por el estudiante: 7 filas; esperado según dataset original: 7. Evidencia visual/export no adjunta. |
| 5 | Ejecutar las consultas en orden (Q1 → Q12) | PASS | El estudiante confirma la ejecución de Q1–Q12 en orden; resultados reportados y registrados en `analysis_report.md`. Capturas/exportaciones no adjuntas localmente. |
| 6 | Calcular las agregaciones (Q9–Q12) después de las correcciones (Q6–Q8) | PASS | Q6–Q8 reportadas como completadas antes de Q9–Q12; resultados de agregación corresponden al estado post-limpieza de 16 matrículas. |
| 7 | Q1: Listar todas las inscripciones del curso `'Intro to Python'`, mostrando nombre del estudiante, email y porcentaje de completado | PASS | SQL revisado y el estudiante confirma ejecución; 5 filas comunicadas. Captura/export Supabase no adjunta. |
| 8 | Q2: Obtener todas las inscripciones donde `completion_percentage` sea menor que 10 — estos son posibles abandonos | PASS | SQL revisado y el estudiante confirma ejecución; 4 filas comunicadas. Captura/export Supabase no adjunta. |
| 9 | Q3: Encontrar todas las inscripciones donde el campo instructor sea `NULL` | PASS | SQL revisado y el estudiante confirma ejecución; 2 filas comunicadas. Captura/export Supabase no adjunta. |
| 10 | Q4: Listar los 5 estudiantes con mayor `completion_percentage` que todavía no han aprobado (`passed = false`) | PASS | SQL revisado y el estudiante confirma ejecución; 5 filas comunicadas. Captura/export Supabase no adjunta. |
| 11 | Q5: Mostrar todas las inscripciones con `enrollment_date` desde el `'2024-07-01'`, ordenadas por `enrollment_date` descendente | PASS | SQL revisado y el estudiante confirma ejecución; 9 filas comunicadas. Captura/export Supabase no adjunta. |
| 12 | Q6: INSERT del registro de inscripción faltante indicado en el brief | PASS | Precheck reportado: count 17, ID 18 ausente, student_id=3/course_id=5 ausente. INSERT devolvió una fila ID 18; postcheck confirmó todos los valores y count 18. Resultado comunicado por el estudiante; captura/export no adjunta. |
| 13 | Q7: UPDATE de todas las inscripciones donde `instructor` sea `NULL` — asignar el valor por defecto `'Pending assignment'` | PASS | Precheck: IDs 10 (Yuki Nakamura) y 11 (Pierre Dubois) con instructor NULL. UPDATE devolvió 2 filas; postcheck `missing_instructors=0`, `corrected_records=2`, `total_enrollments=18`. Resultados comunicados; captura/export no adjunta. |
| 14 | Q8: DELETE de todas las inscripciones ligadas a las cuentas de prueba importadas (`@test.com`) | PASS | Precheck: IDs 13 (James Miller, $49.99) y 14 (Alex Chen, $39.99). DELETE devolvió 2 filas; postcheck total=16, remaining_test_accounts=0, remaining_deleted_ids=0. Resultados comunicados; captura/export no adjunta. |
| 15 | Q8: confirmar las filas afectadas con un SELECT previo | PASS | Precheck comunicado identificó las filas objetivo IDs 13 y 14, ambas con email `@test.com`; evidencia visual/export no adjunta. |
| 16 | Q9: Contar el número de inscripciones agrupado por `category` | PASS | SQL ejecutado según estudiante; Programming 7, Design 4, Data 3, Marketing 2; total 16. Resultado comunicado; captura/export no adjunta localmente. |
| 17 | Q10: Calcular el promedio de `completion_percentage` agrupado por `course_title`, ordenado de menor a mayor | PASS | SQL ejecutado según estudiante; seis promedios registrados en `analysis_report.md`, de UI/UX Fundamentals 0.00% a Intro to Python 80.00%. Captura/export no adjunta. |
| 18 | Q11: Mostrar únicamente los cursos con más de 3 inscripciones (usar `HAVING`) | PASS | SQL con `HAVING COUNT(*) > 3` ejecutado según estudiante; Intro to Python 4. Resultado comunicado; captura/export no adjunta. |
| 19 | Q12: Calcular los ingresos totales (`SUM` de `monthly_fee_paid`) agrupados por `category`, ordenados de mayor a menor | PASS | SQL ejecutado según estudiante; Programming 409.93, Data 179.97, Design 169.96, Marketing 59.98; total 819.84. Captura/export no adjunta. |
| 20 | Escribir en `analysis_report.md` una sección por cada consulta (Q1 a Q12) con el resultado real que devolvió | PASS | Secciones Q1–Q12 contienen los resultados comunicados, recuentos y observaciones; capturas/exportaciones de Supabase no adjuntas localmente. |
| 21 | Antes de ejecutar cualquier UPDATE, ejecutar siempre un SELECT con la misma condición WHERE para confirmar que estás apuntando a las filas correctas | PASS | Precheck Q7 reportado: IDs 10 y 11 tenían `instructor IS NULL`; UPDATE afectó esos dos IDs y postcheck confirmó cero instructores NULL. |
| 22 | Antes de ejecutar cualquier DELETE, ejecutar siempre un SELECT con la misma condición WHERE para confirmar que estás apuntando a las filas correctas | PASS | Precheck Q8 reportado identificó IDs 13 y 14 con email `@test.com`; postcheck confirmó cero cuentas de prueba y ausencia de dichos IDs. |
| 23 | Crear un repositorio vacío en GitHub y agregar en su raíz dos archivos: `queries.sql` (tus consultas) y `analysis_report.md` (tus resultados); asegurar que ambos archivos estén en la raíz del repositorio y que el repo sea público | BLOCKED | Pendiente de aprobación final antes de crear/publicar el repositorio y subir archivos. |
| 24 | Asegurarse de que la versión final de `queries.sql` y `analysis_report.md` esté guardada (commit y push) en el repositorio; entregar el enlace en la vista del proyecto | BLOCKED | Pendiente de aprobación final antes del commit/push; no se han creado commits ni URL de entrega. |

## 8 criterios oficiales de evaluación

Redacción reproducida de «Qué vamos a evaluar» en el README oficial.

| # | Criterio oficial | Estado | Evidencia / motivo |
|---:|---|---|---|
| 1 | Las 12 consultas están presentes en `queries.sql` y se ejecutan sin errores en Supabase | PASS | Q1–Q12 incluidas en orden; el estudiante confirma ejecución en Supabase y comunica resultados para cada consulta. No se adjuntaron capturas/exportaciones locales. |
| 2 | Las consultas SELECT devuelven las filas y columnas correctas según las condiciones especificadas | PASS | SQL y resultados Q1–Q5 y Q9–Q12 comunicados; columnas, filtros/agrupaciones y cantidades/valores corresponden a las tareas reportadas. Evidencia visual local no adjunta. |
| 3 | El INSERT añade el registro correcto con todos los campos requeridos | PASS | El estudiante confirma una fila devuelta (ID 18), todos los valores esperados y count 17→18; evidencia comunicada, captura/export no adjunta. La sentencia registrada contiene las 12 columnas y `RETURNING *`. |
| 4 | El UPDATE afecta únicamente a las filas con instructor `NULL` y asigna el valor por defecto correcto | PASS | Se reportan dos filas objetivo (IDs 10 y 11), ambas cambiadas a `Pending assignment`; postcheck `missing_instructors=0`, `corrected_records=2`. No se adjuntó captura/export. |
| 5 | El DELETE elimina únicamente los registros con `@test.com` y ningún otro | PASS | Se reportan solo IDs 13 y 14 (`@test.com`) eliminados; postcheck `remaining_test_accounts=0`, `remaining_deleted_ids=0`, total=16. No se adjuntó captura/export. |
| 6 | Las consultas con GROUP BY producen las agregaciones correctas (count, average, sum) | PASS | Q9, Q10 y Q12 ejecutadas según estudiante; conteos, promedios y sumas registrados en el informe y coherentes con total 16. Resultados comunicados; no hay capturas locales. |
| 7 | HAVING se utiliza correctamente para filtrar resultados agregados | PASS | Q11 usa `HAVING COUNT(*) > 3` y reporta Intro to Python con 4 matrículas. Resultado comunicado; captura/export no adjunta. |
| 8 | `analysis_report.md` tiene una sección para cada consulta con el resultado real completado (no en blanco) | PASS | Las 12 secciones tienen resultados, conteos y observaciones reportados; no se adjuntaron capturas/exportaciones. |

## Inspección del dataset original (solo lectura)

`edutrack.sql` es UTF-8, 128 líneas, 8,134 bytes. Se descargó del enlace raw oficial; el hash anterior permite comprobar integridad local. No se ejecutó ninguna sentencia SQL. El archivo incluye instrucciones `DROP TABLE IF EXISTS` para `enrollments`, `students` y `courses`; por seguridad, impórtalo solo en un proyecto Supabase nuevo/desechable, no en una base que contenga datos que deban conservarse.

### Tablas, columnas y tipos definidos en el archivo

- `students`: `id SERIAL PRIMARY KEY`; `name VARCHAR(100) NOT NULL`; `email VARCHAR(150) NOT NULL UNIQUE`; `signup_date DATE NOT NULL`.
- `courses`: `id SERIAL PRIMARY KEY`; `title VARCHAR(150) NOT NULL`; `category VARCHAR(50) NOT NULL`; `instructor_name VARCHAR(100)` nullable; `monthly_fee DECIMAL(6,2) NOT NULL`.
- `enrollments`: `id SERIAL PRIMARY KEY`; `student_id INTEGER NOT NULL`; `student_name VARCHAR(100) NOT NULL`; `student_email VARCHAR(150) NOT NULL`; `course_id INTEGER NOT NULL`; `course_title VARCHAR(150) NOT NULL`; `category VARCHAR(50) NOT NULL`; `enrollment_date DATE NOT NULL`; `completion_percentage INTEGER NOT NULL DEFAULT 0`; `passed BOOLEAN NOT NULL DEFAULT FALSE`; `monthly_fee_paid DECIMAL(6,2) NOT NULL`; `instructor VARCHAR(100)` nullable.

No aparecen declaraciones `FOREIGN KEY` ni otras restricciones CHECK en el DDL de `enrollments`. Las PK son `id`; en `students.email` se declara UNIQUE. El archivo inicializa explícitamente 10 estudiantes, 7 cursos y 17 matrículas. Esta es una lectura del script, no una verificación de importación en Supabase. El archivo contiene inserts para las tres tablas como parte del setup; el estudiante no debe ejecutar modificaciones adicionales sobre `students` o `courses`.

### Valores del registro que falta (Q6, según comentario literal del dataset)

- `id = 18`
- `student_id = 3`; `student_name = Lucia Fernandes`; `student_email = lucia.fernandes@student.edutrack.com`
- `course_id = 5`; `course_title = Advanced Python`; `category = Programming`
- `enrollment_date = 2025-04-01`; `completion_percentage = 0`; `passed = false`
- `monthly_fee_paid = 69.99`; `instructor = Carlos Vega`

Estos son datos de entrada publicados por el brief; no constituyen una solución SQL. La sentencia INSERT Q6 registrada en `queries.sql` fue comunicada por el estudiante como ejecutada y verificada; no se ejecutó durante esta sesión.

## Validación del entorno y seguridad

| Control | Estado | Evidencia |
|---|---|---|
| Workspace correcto | PASS | `/Users/franciscogarcia/Projects/edutrack-data-audit-sql`; Git root coincide. |
| `queries.sql` existe en la raíz | PASS | Archivo presente; contiene Q1–Q12 en orden y advierte que no se reejecuten las mutaciones históricas Q6–Q8. |
| `analysis_report.md` existe en la raíz | PASS | Archivo presente; contiene las 12 secciones con resultados comunicados, observaciones y limitaciones de evidencia. |
| Dataset oficial existe y es legible | PASS | `edutrack.sql`, UTF-8, SHA-256 registrado arriba; descargado desde el raw oficial. |
| Validación contiene requisitos y criterios oficiales | PASS | Secciones anteriores; texto cotejado con README.es.md oficial. |
| Credenciales en archivos inspeccionados | PASS (alcance local) | No se encontraron credenciales en los archivos del proyecto inspeccionados. Mantener secretos fuera del repo. |
| Mutaciones SQL del estudiante | PASS (Q6–Q8 reportadas) | Q6 insertó ID 18; Q7 actualizó 2 filas; Q8 eliminó 2 filas. El estado final reportado es 16 enrollments, 0 instructores NULL y 0 cuentas `@test.com`. No se ejecutaron mutaciones en esta sesión. |
| Importación Supabase | PASS | Importación del dataset original confirmada por el estudiante; conteos iniciales reportados: 17 enrollments, 10 students, 7 courses. Después de Q6/Q7: 18 enrollments; después de Q8: 16. |
| Cambios a `students` / `courses` posteriores a setup | PASS (ninguno) | No se ejecutaron comandos de base de datos. El script oficial inicializó estas tablas como parte del import en Supabase; no se reportan modificaciones adicionales. |
| Commit, push o pull request | BLOCKED (pendiente de aprobación) | Sin commit ni push; no hay remoto Git configurado ni PR creada. |

### Evidencia / publicación pendiente

- Capturas de Supabase revisadas durante la conversación, pero no guardadas en `docs/evidence/`. Añadirlas redactadas si la plataforma de entrega exige evidencia local.
- Crear o seleccionar remoto GitHub público, configurar `origin`, aprobar commit/push y entregar URL final.
- Los resultados Q1–Q12 son los comunicados por el estudiante; no hay export local verificable independiente.
- No incluir contraseñas, tokens, cadenas de conexión ni datos personales innecesarios en capturas o Git.

## Reproducibilidad y seguridad

- `queries.sql` contiene 12 consultas en orden y sin placeholders. Para reproducir desde cero, importar el dataset oficial una sola vez en una base Supabase nueva/desechable y ejecutar las consultas secuencialmente. Q6–Q8 son mutaciones históricas y no deben volver a ejecutarse contra la base actual ya limpia.
- No reejecutar `edutrack.sql` en la base actual: contiene `DROP TABLE IF EXISTS` y reinicializaría/eliminaría las tablas.
- El INSERT Q6 asignó explícitamente ID 18 en una columna `SERIAL`; PostgreSQL no avanza la secuencia al insertar manualmente IDs. No hubo más INSERT en el flujo actual. Antes de un futuro INSERT con ID generado, sincronizar la secuencia en un paso separado y revisado; ejemplo documentado, no ejecutado:
  `SELECT setval(pg_get_serial_sequence('public.enrollments', 'id'), (SELECT MAX(id) FROM public.enrollments), true);`
- El dataset inicializa `students` y `courses`; no se reportan modificaciones posteriores a esas tablas.
- Escaneo local de patrones comunes de secretos: sin hallazgos. Alcance limitado a los archivos presentes, no sustituye un escáner de secretos dedicado ni la revisión del contenido antes de publicar.
