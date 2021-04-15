
CREATE OR REPLACE FUNCTION teachers_loading
    (p_teacher_id IN course_sections.emp_id%TYPE, p_semester course_sections.term%TYPE, p_year course_sections.year%TYPE) RETURN NUMBER IS
    p_hours NUMBER:=0;
    CURSOR cur_teacher IS
        SELECT * FROM course_sections WHERE emp_id = p_teacher_id AND term = p_semester AND year = p_year;
BEGIN
    FOR v_teacher_record IN cur_teacher
    LOOP
        EXIT WHEN cur_teacher%NOTFOUND;
        IF v_teacher_record.hour_num IS NULL THEN
            p_hours:= p_hours+ 15;
        ELSE
            p_hours:= p_hours + v_teacher_record.hour_num;
        END IF;
    END LOOP;

    RETURN p_hours;
END;




BEGIN
    HTP.P('<p>'||teachers_loading('10166',1,2015)||' hours</p>');
END;
