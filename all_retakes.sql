CREATE OR REPLACE FUNCTION all_retakes 
    RETURN NUMBER IS
    p_money NUMBER:= 0;
    CURSOR cur_retakes IS
        SELECT * FROM course_selections WHERE qiymet_yuz < 50;
    v_credit course_sections.credits%TYPE;
    p_retakes NUMBER:=0;
BEGIN
    FOR v_retakes_record IN cur_retakes
    LOOP
        EXIT WHEN cur_retakes%NOTFOUND;
        p_retakes := p_retakes + 1;
        project_pkg.get_credits(v_retakes_record.ders_kod, v_credit);
        p_money := p_money + (v_credit * 25000);
    END LOOP;
    RETURN p_money;
END;




BEGIN
HTP.P('<p>'||all_retakes||'</p>');
END;
