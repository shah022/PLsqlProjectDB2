
CREATE OR REPLACE PROCEDURE not_reg_students
    (p_semester course_selections.term%TYPE, p_year course_selections.year%TYPE) IS
    CURSOR cur_not_reg_stud IS
        SELECT t1.stud_id AS student FROM 
            (SELECT DISTINCT stud_id FROM course_selections 
                WHERE (year<p_year OR (year=p_year AND term<p_semester))
                AND (stud_id NOT IN (SELECT stud_id FROM course_selections WHERE year = p_year AND term = p_semester))) t1 
        INNER JOIN
            (SELECT DISTINCT stud_id FROM course_selections 
                WHERE (year>p_year OR (year = p_year AND term>p_semester))
                AND (stud_id NOT IN (SELECT stud_id FROM course_selections WHERE year = p_year AND term = p_semester))) t2
        ON t1.stud_id = t2.stud_id;
BEGIN
    FOR v_not_reg_stud_record IN cur_not_reg_stud
    LOOP
        EXIT WHEN cur_not_reg_stud%NOTFOUND;
        HTP.P('<p>'||v_not_reg_stud_record.student||'</p>');
    END LOOP;
END;


BEGIN
  not_reg_students(2, 2016);
END;