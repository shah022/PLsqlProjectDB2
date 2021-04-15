CREATE TABLE wish_list_stud(
    st_stud_id VARCHAR2(30),
    st_DERS_KOD VARCHAR(20),
    st_year NUMBER,
    st_term NUMBER
);

CREATE TABLE wish_lists(
    stud_id VARCHAR2(30),
    DERS_KOD VARCHAR(20),
    year NUMBER,
    term NUMBER,
    reg_date DATE
);



CREATE OR REPLACE PROCEDURE add_to_w_l
    (p_ders_kod wish_list_stud.st_ders_kod%TYPE, p_year wish_list_stud.st_year%TYPE, p_term wish_list_stud.st_term%TYPE) IS
BEGIN
    EXECUTE IMMEDIATE 'INSERT INTO wish_list_stud(st_stud_id, st_ders_kod, st_year, st_term) VALUES (USER, '''||p_ders_kod||''', '||p_year||', '||p_term||')';
END;




CREATE OR REPLACE TRIGGER add_wish_lists_trg
AFTER INSERT ON wish_list_stud
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    INSERT INTO wish_lists(stud_id, ders_kod, year, term, reg_date) VALUES (:new.st_stud_id, :new.st_ders_kod, :new.st_year, :new.st_term, SYSDATE);
END;


CREATE OR REPLACE PROCEDURE submit IS
BEGIN
    DELETE FROM wish_list_stud;
    COMMIT;
END;





BEGIN
  add_to_w_l('CSS 222', 2020, 2);
END;

BEGIN
    submit;
END;


