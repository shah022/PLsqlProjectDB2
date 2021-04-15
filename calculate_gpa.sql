CREATE OR REPLACE FUNCTION calculate_gpa
    (p_stud_id IN course_selections.stud_id%TYPE) RETURN NUMBER IS
    p_gpa NUMBER(8,2);
    CURSOR cur_student IS
        SELECT * FROM course_selections WHERE stud_id = p_stud_id;
    v_sum_point_cr NUMBER := 0;
    v_sum_credits NUMBER := 0;
    v_point NUMBER;
    v_credit course_sections.credits%TYPE;
BEGIN
    FOR v_student_record IN cur_student
    LOOP
        
        EXIT WHEN cur_student%NOTFOUND;
        project_pkg.herf_to_point(v_student_record.qiymet_herf, v_point);
        project_pkg.get_credits(v_student_record.ders_kod, v_credit);
        IF v_point IS NOT NULL THEN
            v_sum_point_cr := v_sum_point_cr + (v_point * v_credit);
            v_sum_credits := v_sum_credits + v_credit;
        END IF;
    END LOOP;
    p_gpa := v_sum_point_cr/v_sum_credits;
    RETURN p_gpa;
END;



BEGIN
    HTP.P('<p> GPA: '||calculate_gpa('32796B8F993147D4BD82B74D4B4EEB2D3A6744FB')||'</p>');
END;