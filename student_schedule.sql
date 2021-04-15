
CREATE OR REPLACE PROCEDURE student_schedule
    (p_stud_id course_selections.stud_id%TYPE, p_semester course_selections.term%TYPE, p_year course_selections.year%TYPE) IS
    CURSOR cur_stud_schedule IS
        SELECT sel.stud_id AS student, sel.ders_kod AS subject, TO_CHAR(sch.start_time, 'Dy') AS w, TO_CHAR(sch.start_time, 'D') AS w_num, TO_CHAR(sch.start_time, 'HH24') AS h 
            FROM course_selections sel, course_schedule sch
            WHERE sel.year = p_year AND sel.term = p_semester AND sel.stud_id = p_stud_id
            AND sel.ders_kod = sch.ders_kod AND sel.section = sch.section AND sel.year = sch.year AND sel.term = sch.term
            ORDER BY w_num, h;
BEGIN
    FOR v_stud_schedule_record IN cur_stud_schedule
    LOOP
        EXIT WHEN cur_stud_schedule%NOTFOUND;
        HTP.P('<p>'||'Day: '||v_stud_schedule_record.w || ', Time: ' || v_stud_schedule_record.h || ':00, Subject: '|| v_stud_schedule_record.subject||'</p>');
    END LOOP;
END;


BEGIN
  student_schedule('588BE0300644AC9220DB5E53AD4B59DFA7D2D722', 1, 2019);
END;
