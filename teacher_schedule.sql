
CREATE OR REPLACE PROCEDURE teacher_schedule
    (p_teacher course_sections.emp_id%TYPE, p_semester course_sections.term%TYPE, p_year course_sections.year%TYPE) IS
    CURSOR cur_teacher_schedule IS
       SELECT sec.emp_id AS teacher, sec.ders_kod AS subject, TO_CHAR(sch.start_time, 'Dy') AS w, TO_CHAR(sch.start_time, 'D') AS w_num, TO_CHAR(sch.start_time, 'HH24') AS h 
            FROM course_sections sec, course_schedule sch
            WHERE sec.year = p_year AND sec.term = p_semester AND sec.emp_id = p_teacher
            AND sec.ders_kod = sch.ders_kod AND sec.section = sch.section AND sec.year = sch.year AND sec.term = sch.term
            ORDER BY w_num, h;
BEGIN
    FOR v_teacher_schedule_record IN cur_teacher_schedule
    LOOP
        EXIT WHEN cur_teacher_schedule%NOTFOUND;
        HTP.P('<p>'||'Day: '||v_teacher_schedule_record.w || ', Time: ' || v_teacher_schedule_record.h || ':00, Subject: '|| v_teacher_schedule_record.subject||'</p>');
    END LOOP;
END;


BEGIN
  teacher_schedule('10713', 1, 2019);
END;

