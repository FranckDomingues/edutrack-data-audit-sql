-- EduTrack — read-only verification references for the checks documented in
-- the conversation/report. The exact historical precheck/postcheck SQL text was
-- not provided, so these are reconstructed reference statements, NOT a verbatim
-- transcript of prior execution. They were NOT executed during this update.
-- Review database stage and expected results before running these references.
-- Schema: public.enrollments, as defined in the official edutrack.sql.

-- Q6 PRECHECK (before the historical INSERT): reported checks were row count,
-- ID 18 existence, and an equivalent student_id/course_id enrollment.
-- Run this only on a fresh dataset if reproducing the precheck; current cleaned
-- database should report different values.
SELECT COUNT(*) AS enrollment_count_before FROM enrollments;

SELECT id, student_id, course_id
FROM enrollments
WHERE id = 18;

SELECT id, student_id, course_id
FROM enrollments
WHERE student_id = 3 AND course_id = 5;

-- Q6 POSTCHECK (after historical INSERT): verify the inserted row's recorded
-- values and count. Read-only; the expected values are in the report, not
-- fabricated here as execution output.
SELECT id, student_id, student_name, student_email, course_id, course_title,
       category, enrollment_date, completion_percentage, passed,
       monthly_fee_paid, instructor
FROM enrollments
WHERE id = 18;

SELECT COUNT(*) AS enrollment_count_after FROM enrollments;

-- Q7 PRECHECK (before historical UPDATE): inspect rows matching the exact
-- UPDATE predicate. The reported execution found IDs 10 and 11.
SELECT id, student_name, course_title, instructor
FROM enrollments
WHERE instructor IS NULL
ORDER BY id;

-- Q7 POSTCHECK (after historical UPDATE): check remaining missing instructors
-- and total row count, corresponding to the reported controls.
SELECT COUNT(*) AS missing_instructors
FROM enrollments
WHERE instructor IS NULL;

SELECT COUNT(*) AS corrected_records
FROM enrollments
WHERE instructor = 'Pending assignment';

SELECT COUNT(*) AS total_enrollments
FROM enrollments;

-- Q8 PRECHECK (before historical DELETE): preview the exact target rows and
-- fee amounts. The reported execution found IDs 13 and 14.
SELECT id, student_name, student_email, course_title, monthly_fee_paid
FROM enrollments
WHERE student_email LIKE '%@test.com'
ORDER BY id;

-- Q8 POSTCHECK (after historical DELETE): verify remaining test accounts,
-- total enrollments, and whether the deleted IDs remain.
SELECT COUNT(*) AS total_enrollments
FROM enrollments;

SELECT COUNT(*) AS remaining_test_accounts
FROM enrollments
WHERE student_email LIKE '%@test.com';

SELECT COUNT(*) AS remaining_deleted_ids
FROM enrollments
WHERE id IN (13, 14);
