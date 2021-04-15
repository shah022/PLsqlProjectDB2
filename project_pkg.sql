
CREATE OR REPLACE PACKAGE project_pkg
IS
    PROCEDURE get_credits
    (p_code IN course_sections.ders_kod%TYPE, p_credits OUT course_sections.credits%TYPE);
    PROCEDURE herf_to_point
    (p_herf IN course_selections.qiymet_herf%TYPE, p_point OUT NUMBER);
END project_pkg;


CREATE OR REPLACE PACKAGE BODY project_pkg IS

    PROCEDURE get_credits
        (p_code IN course_sections.ders_kod%TYPE, p_credits OUT course_sections.credits%TYPE) IS
    BEGIN
        SELECT MAX(credits) INTO p_credits FROM course_sections WHERE DERS_KOD = p_code;
        IF p_credits IS NULL THEN
            p_credits := 3;
        END IF;
    END get_credits;
    
    PROCEDURE herf_to_point
    (p_herf IN course_selections.qiymet_herf%TYPE, p_point OUT NUMBER) IS
        TYPE points IS TABLE OF NUMBER INDEX BY course_selections.qiymet_herf%TYPE; 
        point_list points; 
    BEGIN
        point_list('A'):= 4;
        point_list('A-'):= 3.67;
        point_list('B+'):= 3.33;
        point_list('B'):= 3;
        point_list('B-'):= 2.67;
        point_list('C+'):= 2.33;
        point_list('C'):= 2;
        point_list('C-'):= 1.67;
        point_list('D+'):= 1.33;
        point_list('D'):= 1;
        point_list('FX'):= 0;
        point_list('FC'):= 0;
        point_list('F'):= 0;

        p_point:= point_list(p_herf);
	EXCEPTION
        WHEN no_data_found THEN NULL;
    END herf_to_point;
END project_pkg;


