CREATE OR REPLACE PROCEDURE popular_teacher
    (p_semester course_selections.term%TYPE, p_year course_selections.year%TYPE, p_code course_selections.ders_kod%TYPE) IS
    CURSOR cur_pop_teacher IS
        SELECT practice, TO_NUMBER(MAX (TO_DATE(reg_date))- MIN (TO_DATE(reg_date))) / COUNT (practice) AS dif
            FROM course_selections
            WHERE term = p_semester AND year = p_year AND ders_kod = p_code 
            GROUP BY (practice)
            ORDER BY dif;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE(p_code);
    FOR v_pop_teacher_record IN cur_pop_teacher
    LOOP
        EXIT WHEN cur_pop_teacher%NOTFOUND;
        HTP.P('<p>'||v_pop_teacher_record.practice||'</p>');
        
    END LOOP;
END;

BEGIN
  popular_teacher(1, 2017, 'FIN 402');
END;


