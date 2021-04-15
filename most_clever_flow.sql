
CREATE OR REPLACE PROCEDURE most_clever_flow
    (p_subject course_selections.ders_kod%TYPE, p_teacher course_selections.practice%TYPE) IS
    CURSOR cur_m_c_f IS
        SELECT year, term, AVG(qiymet_yuz) AS rating FROM course_selections
            WHERE DERS_KOD = p_subject AND practice = p_teacher
            GROUP BY year, term
            ORDER BY rating DESC;
BEGIN
    FOR v_m_c_f_record IN cur_m_c_f
    LOOP
        EXIT WHEN cur_m_c_f%ROWCOUNT > 1;
        HTP.P('<p> Year: '||v_m_c_f_record.year||'</p>');
        HTP.P('<p> Term: '||v_m_c_f_record.term||'</p>');
        HTP.P('<p> Rating: '||v_m_c_f_record.rating||'</p>');
    END LOOP;
END;


BEGIN
  most_clever_flow('TFL 239', 21963);
END;
