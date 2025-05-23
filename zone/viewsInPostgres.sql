
-- Views in PostgreSQL (Based on 10-4)
-- Create a view to show each student’s name, department, and score.

CREATE OR REPLACE VIEW joining_view AS
SELECT
    students.id AS student_id,
    students.name AS student_name,
    departments.name AS department_name,
    students.score
FROM students
JOIN departments ON students.department_id = departments.id;


SELECT * FROM joining_view;


CREATE OR REPLACE VIEW student_view 
AS
SELECT 
    student_name,
    department_name,
    score
FROM joining_view;

SELECT * FROM student_view;

-- Create a view that lists all students enrolled in any course with the enrollment date.

CREATE or replace view enrollment_joining
AS
SELECT 
course_enrollment.id AS course_id,
students.name AS student_name,
course_enrollment.course_title,
course_enrollment.enroll_on
FROM course_enrollment
JOIN students ON  course_enrollment.student_id = students.id;


SELECT* FROM course_enrollment;
SELECT* FROM students

SELECT* FROM enrollment_joining

-- Query from your created views to verify the data.
