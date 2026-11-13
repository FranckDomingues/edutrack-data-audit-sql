# Auditoría de Datos en EduTrack

Proyecto SQL de 4Geeks Academy sobre el dataset oficial EduTrack. `queries.sql` contiene las doce consultas ejecutadas, en orden, y `analysis_report.md` documenta los resultados comunicados desde Supabase. La fuente de requisitos, los 24 controles de auditoría derivados y los ocho criterios oficiales se encuentran en `docs/VALIDATION.md`.

## Estado final reportado

- Dataset oficial `edutrack.sql`: descargado y revisado; no se debe ejecutar nuevamente contra la base actual porque incluye `DROP TABLE IF EXISTS`.
- Importación inicial confirmada: `students` 10, `courses` 7, `enrollments` 17.
- Q1–Q5: resultados del estado previo a las mutaciones.
- Q6: una matrícula añadida (ID 18); conteo 17→18.
- Q7: dos instructores NULL corregidos (IDs 10 y 11); faltantes reportados después: 0.
- Q8: dos matrículas de prueba eliminadas (IDs 13 y 14); conteo final: 16; cuentas de prueba restantes: 0.
- Q9–Q12: resultados del estado post-limpieza, documentados en el informe. Q9: cuatro categorías; Q10: promedio menor 0.00% en UI/UX Fundamentals y mayor 80.00% en Intro to Python; Q11: Intro to Python con 4 matrículas; Q12: suma de 819.84 de los valores registrados en `monthly_fee_paid`.
- `monthly_fee_paid` es un importe mensual registrado por matrícula; su suma no demuestra ingresos recurrentes ni representa ingresos de producción verificados.

Los resultados de ejecución fueron comunicados por el estudiante. Las capturas de Supabase se revisaron en la conversación, pero no se guardaron en `docs/evidence/` ni en otra ubicación del repositorio.

## Seguridad y reproducibilidad

Q6–Q8 son mutaciones históricas: **no las vuelvas a ejecutar en la base Supabase actual**. No vuelvas a ejecutar `edutrack.sql` allí, pues elimina/recrea tablas. Para una reproducción integral, usa una base Supabase nueva/desechable, importa el dataset oficial una vez y ejecuta `queries.sql` secuencialmente, en el orden documentado. No se reportan modificaciones posteriores a `students` ni `courses`.

El INSERT de Q6 suministra explícitamente `id = 18` a una columna `SERIAL`; PostgreSQL no actualiza automáticamente la secuencia asociada al ID manual. Antes de futuros INSERT con ID generado, verifica y sincroniza la secuencia en una operación separada y revisada. Un ejemplo está documentado en `analysis_report.md`; no se ha ejecutado contra Supabase.

## Publicación

El repositorio local no tiene commits ni remoto configurado. Antes de publicar, revisar diffs y secretos, acordar el repositorio GitHub público y aprobar explícitamente commit/push. No se ha creado pull request.
