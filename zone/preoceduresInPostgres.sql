## ⚙️ Stored Procedures (10-6)

-- - **Write a stored procedure to update a student's department.**
CREATE OR REPLACE PROCEDURE update_student_department(
    p_student_id INT,
    p_new_department_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE students
    SET department_id = p_new_department_id
    WHERE id = p_student_id;

    RAISE NOTICE 'Student ID % department updated to %', p_student_id, p_new_department_id;
END;
$$;

CALL update_student_department(1, 2);

-- - **Write a procedure to delete students who haven't enrolled in any course.**

CREATE OR REPLACE PROCEDURE delete_unenrolled_students()
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM students
    WHERE id NOT IN (
        SELECT DISTINCT student_id FROM course_enrollments
    );

    RAISE NOTICE 'All unenrolled students have been deleted.';
END;
$$;
