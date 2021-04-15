
CREATE OR REPLACE PROCEDURE subject_and_credit
    (p_stud_id IN course_selections.stud_id%TYPE, p_subject OUT NUMBER, p_credits OUT NUMBER) IS
    CURSOR cur_subjects IS
        SELECT * FROM course_selections WHERE stud_id = p_stud_id;
    v_credit course_sections.credits%TYPE;
    v_sub NUMBER:=0;
    v_cr NUMBER:=0;
BEGIN
    FOR v_subjects_record IN cur_subjects
    LOOP
        EXIT WHEN cur_subjects%NOTFOUND;
        v_sub := v_sub + 1;
        project_pkg.get_credits(v_subjects_record.ders_kod, v_credit);
        v_cr := v_cr + v_credit;
    END LOOP;
    p_subject := v_sub;
    p_credits := v_cr;
END;


DECLARE
    v_credit NUMBER;
    v_subject NUMBER;
BEGIN
    subject_and_credit('588BE0300644AC9220DB5E53AD4B59DFA7D2D722',v_subject, v_credit);
    HTP.P('<p> Subjects: '||v_subject||'</p>');
    HTP.P('<p> Credits: '||v_credit||'</p>');

END;