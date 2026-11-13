-- Auditoría de Datos en EduTrack — Q1–Q12 registradas en orden.
-- Q6–Q8 son mutaciones históricas ejecutadas en Supabase; NO volver a ejecutarlas
-- contra la base actual. El archivo completo solo se ejecuta una vez sobre una
-- importación oficial nueva, en orden, con los resultados verificados.


-- Q1: List students, emails, and completion for Intro to Python.
SELECT student_name, student_email, completion_percentage
FROM enrollments
WHERE course_title = 'Intro to Python';

-- Q2: Find enrollments with completion below 10%, lowest first.
SELECT student_name, student_email, course_title, completion_percentage
FROM enrollments
WHERE completion_percentage < 10
ORDER BY completion_percentage ASC;

-- Q3: Identify enrollments whose instructor is missing (NULL).
SELECT id, student_name, course_title, instructor
FROM enrollments
WHERE instructor IS NULL
ORDER BY id;

-- Q4: List the five most-complete enrollments not yet passed.
SELECT student_name, course_title, completion_percentage, passed
FROM enrollments
WHERE passed = false
ORDER BY completion_percentage DESC
LIMIT 5;

-- Q5: List enrollments dated July 1, 2024 or later, newest first.
SELECT id, student_name, course_title, enrollment_date
FROM enrollments
WHERE enrollment_date >= '2024-07-01'
ORDER BY enrollment_date DESC;

-- Q6: Insert the missing official enrollment (historical mutation; already executed, do not rerun).
INSERT INTO enrollments (
    id,
    student_id,
    student_name,
    student_email,
    course_id,
    course_title,
    category,
    enrollment_date,
    completion_percentage,
    passed,
    monthly_fee_paid,
    instructor
)
VALUES (
    18,
    3,
    'Lucia Fernandes',
    'lucia.fernandes@student.edutrack.com',
    5,
    'Advanced Python',
    'Programming',
    '2025-04-01',
    0,
    false,
    69.99,
    'Carlos Vega'
)
RETURNING *;

-- Q7: Fill missing instructor values (historical mutation; already executed, do not rerun).
UPDATE enrollments
SET instructor = 'Pending assignment'
WHERE instructor IS NULL
RETURNING id, student_name, course_title, instructor;

-- Q8: Remove test-account enrollments (historical mutation; already executed, do not rerun).
DELETE FROM enrollments
WHERE student_email LIKE '%@test.com'
RETURNING id, student_name, student_email, course_title, monthly_fee_paid;

-- Las mutaciones Q6–Q8 ya se ejecutaron; no repetirlas en la base actual.
-- Q9–Q12 son SELECT post-limpieza y pueden ejecutarse de forma no destructiva.

-- Q9: Count enrollments in each category after cleanup.
SELECT category, COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY category
ORDER BY total_enrollments DESC;

-- Q10: Compare average completion percentages by course.
SELECT course_title,
ROUND(AVG(completion_percentage), 2) AS average_completion
FROM enrollments
GROUP BY course_title
ORDER BY average_completion ASC;

-- Q11: Show courses with more than three enrollments.
SELECT course_title,
COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY course_title
HAVING COUNT(*) > 3
ORDER BY total_enrollments DESC;

-- Q12: Sum recorded monthly fees by category after cleanup.
-- Suma los importes mensuales registrados; no demuestra ingresos recurrentes reales.
SELECT category,
ROUND(SUM(monthly_fee_paid), 2) AS total_revenue
FROM enrollments
GROUP BY category
ORDER BY total_revenue DESC;
