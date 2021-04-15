CREATE OR REPLACE FUNCTION money_for_retake_all
    (p_stud_id IN course_selections.stud_id%TYPE) RETURN NUMBER IS
    p_money NUMBER:=0;
    CURSOR cur_student IS
        SELECT * FROM course_selections WHERE qiymet_yuz < 50 AND stud_id = p_stud_id;
    v_credit course_sections.credits%TYPE;
BEGIN
    FOR v_student_record IN cur_student
    LOOP
        EXIT WHEN cur_student%NOTFOUND;
        project_pkg.get_credits(v_student_record.ders_kod, v_credit);
        p_money := p_money + (v_credit * 25000);
    END LOOP;

    RETURN p_money;
END;



BEGIN
HTP.P('<p>'||money_for_retake_all('D7024A31F3D95B7E7F8C3A5B00BE37E4232CFC2A')||'</p>');
END;

