SET SERVEROUTPUT ON

--1 ���. �������� �������
CREATE TABLE chessmens(
    f_type VARCHAR2(20),
    start_letter VARCHAR2(3),
    start_num NUMBER,
    dest_letter VARCHAR2(3),
    dest_num NUMBER
);
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


--2 ���. �������� � ������� ��������
INSERT INTO chessmens VALUES('knight','E', 5, 'D', 5);
INSERT INTO chessmens VALUES('knight','E', 5, 'C', 4);
INSERT INTO chessmens VALUES('queen','C', 6, 'D', 3);
INSERT INTO chessmens VALUES('queen','C', 6, 'E', 8);
INSERT INTO chessmens VALUES('knight','D', 5, 'E', 5);
INSERT INTO chessmens VALUES('bishop','E', 6, 'B', 3);
INSERT INTO chessmens VALUES('bishop','E', 6, 'F', 4);
INSERT INTO chessmens VALUES('rook','C', 3, 'C', 8);
INSERT INTO chessmens VALUES('rook','C', 3, 'A', 8);
INSERT INTO chessmens VALUES('king','G', 4, 'G', 5);
INSERT INTO chessmens VALUES('king','G', 4, 'I', 5);
INSERT INTO chessmens VALUES('pawn(white)','H', 2, 'H', 4);
INSERT INTO chessmens VALUES('pawn(black)','H', 7, 'H', 5);
INSERT INTO chessmens VALUES('pawn(white)','H', 2, 'H', 3);
INSERT INTO chessmens VALUES('queen','C', 6, 'D', 10);
INSERT INTO chessmens VALUES('queen','C', 6, 'K', 0);
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


--3 ���. �������� ��������� ������� ����� ��������� ��������� � �������� �������� �� ���� ������
CREATE OR REPLACE PROCEDURE check_move
    (p_type VARCHAR2, p_st_let VARCHAR2, p_st_num NUMBER, p_dest_let VARCHAR2, p_dest_num NUMBER) IS
    v_d_l_a NUMBER:= ASCII(p_dest_let);
    v_s_l_a NUMBER:= ASCII(p_st_let);
    v_info_figure VARCHAR2(255):= 'Type: '||p_type||'. Start: '||p_st_let||p_st_num||'. Destination: '||p_dest_let||p_dest_num||'. '; --���������� � ������
    v_out_can VARCHAR2(255):= v_info_figure||'Chess piece can make a move';  --����� ������� ���
    v_out_cannot VARCHAR2(255):= v_info_figure||'Chess piece cannot make a move';  --������ ������� ���
    v_count NUMBER:=0;
BEGIN
    SELECT COUNT(*) INTO v_count FROM chessmens WHERE start_letter = p_dest_let AND start_num = p_dest_num;

    --��������� �� ������� �� ������ �� ������� �����
    IF (v_d_l_a > 72 OR v_d_l_a <65 OR p_dest_num <1 OR p_dest_num >8) THEN 
        DBMS_OUTPUT.PUT_LINE(v_info_figure||'The figure goes beyond the chessboard');
    
    --��������� ���� �� ����� �� ������ �� ����� �������� �������
    ELSIF (v_count > 0) THEN
        DBMS_OUTPUT.PUT_LINE(v_info_figure||'A piece cannot make a move, another piece is in the final position');
    
    
    --��������� ��� ������, ���� �����
     --��������� ����� �� ��� � �������� ������� �� ����������� � �� ���������, �� �������� ������� �� ��������� ������ ���� ������ �� 1
     -- ���� ����� ��������� � ��������� ��������� �� ����� ������� 2 ���� ������
    ELSIF (p_type = 'pawn(white)') THEN --��� ����� �����
        IF(v_d_l_a = v_s_l_a AND p_st_num = (p_dest_num-1)) THEN 
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSIF(v_d_l_a = v_s_l_a AND p_st_num = 2 AND p_st_num = (p_dest_num-2)) THEN
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSE DBMS_OUTPUT.PUT_LINE(v_out_cannot);
        END IF;
        
    ELSIF (p_type = 'pawn(black)') THEN --��� ������ �����
        IF(v_d_l_a = v_s_l_a AND p_st_num = (p_dest_num+1)) THEN 
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSIF(v_d_l_a = v_s_l_a AND p_st_num = 7 AND p_st_num = (p_dest_num+2)) THEN
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSE DBMS_OUTPUT.PUT_LINE(v_out_cannot);
        END IF;

    --��������� ��� ������, ���� ������
    --����� �� ������ ��� � �����, �� ��� ��������� ��� �������� ������
    ELSIF (p_type = 'king') THEN  
        IF(v_d_l_a = v_s_l_a AND (p_st_num = (p_dest_num+1) OR p_st_num = (p_dest_num-1))) THEN 
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSIF(p_st_num = p_dest_num AND (v_s_l_a = (v_d_l_a+1) OR v_s_l_a = (v_d_l_a-1))) THEN
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSIF(p_st_num = (p_dest_num-1) AND (v_s_l_a = (v_d_l_a+1) OR v_s_l_a = (v_d_l_a-1))) THEN
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSIF(p_st_num = (p_dest_num+1) AND (v_s_l_a = (v_d_l_a+1) OR v_s_l_a = (v_d_l_a-1))) THEN
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSE DBMS_OUTPUT.PUT_LINE(v_out_cannot);
        END IF;


    --��������� ������, ���� �����
    --��� ������ ������� �����, ���� ��������� � �������� ����� ��� ����� ����� �� ����� ������� ���
    ELSIF(p_type = 'rook') THEN   
        IF(v_d_l_a = v_s_l_a OR p_dest_num = p_st_num) THEN 
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSE DBMS_OUTPUT.PUT_LINE(v_out_cannot);
        END IF;

    
    --��������� ������, ���� ����
    --��� ������ �����, ��� ���� ����� �� ��������� � ���� ��� ����� �� �������� �������� ����� ��
    -- ��������� ������� �������� ����� � ��������� �����, �������� ����� � ��� �����, ���� ����� �� ������ ����� ������� ���
    ELSIF(p_type = 'bishop') THEN 
        IF((p_dest_num - p_st_num)=(v_d_l_a - v_s_l_a)) THEN 
            DBMS_OUTPUT.PUT_LINE(v_out_can);                 
        ELSE DBMS_OUTPUT.PUT_LINE(v_out_cannot);
        END IF;

    --��������� ������, ���� �����
    --����� ��� ���� + �����
    ELSIF(p_type = 'queen') THEN    
        IF(v_d_l_a = v_s_l_a OR p_dest_num = p_st_num) THEN  
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSIF((p_dest_num - p_st_num)=(v_d_l_a - v_s_l_a)) THEN 
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSE DBMS_OUTPUT.PUT_LINE(v_out_cannot);
        END IF;


    --��������� ������, ���� ����
    --���� ����� � �������, �.� ������� � ��������� � �������� ���������� ������ ���� 1 � 2
    ELSIF(p_type = 'knight') THEN   
        IF(((p_dest_num-p_st_num = 2) OR (p_dest_num-p_st_num = -2)) AND ((v_d_l_a - v_s_l_a = 1) OR (v_d_l_a - v_s_l_a = -1))) THEN
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSIF(((p_dest_num-p_st_num = 1) OR (p_dest_num-p_st_num = -1)) AND ((v_d_l_a - v_s_l_a = 2) OR (v_d_l_a - v_s_l_a = -2))) THEN
            DBMS_OUTPUT.PUT_LINE(v_out_can);
        ELSE DBMS_OUTPUT.PUT_LINE(v_out_cannot);
        END IF;
    END IF;
END;
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------



--4 ���. �������� ��������� ������� ��������� chessmens ������� � �������� check_move ��������� ��� ��������
CREATE OR REPLACE PROCEDURE scan_and_check IS
    CURSOR cur_chess IS
        SELECT * FROM chessmens;
BEGIN
    FOR v_chess_record IN cur_chess
    LOOP
        EXIT WHEN cur_chess%NOTFOUND;
        check_move(v_chess_record.f_type,v_chess_record.start_letter,v_chess_record.start_num,v_chess_record.dest_letter,v_chess_record.dest_num);
    END LOOP;
END;
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------



--5 ���. ��������� ��� ��� �� �������� ����
BEGIN
  scan_and_check;
END;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


--���������
/*
Type: knight. Start: E5. Destination: D5. A piece cannot make a move, another piece is in the final position
Type: knight. Start: E5. Destination: C4. Chess piece can make a move
Type: queen. Start: C6. Destination: D3. Chess piece cannot make a move
Type: queen. Start: C6. Destination: E8. Chess piece can make a move
Type: knight. Start: D5. Destination: E5. A piece cannot make a move, another piece is in the final position
Type: bishop. Start: E6. Destination: B3. Chess piece can make a move
Type: bishop. Start: E6. Destination: F4. Chess piece cannot make a move
Type: rook. Start: C3. Destination: C8. Chess piece can make a move
Type: rook. Start: C3. Destination: A8. Chess piece cannot make a move
Type: king. Start: G4. Destination: G5. Chess piece can make a move
Type: king. Start: G4. Destination: I5. The figure goes beyond the chessboard
Type: pawn(white). Start: H2. Destination: H4. Chess piece can make a move
Type: pawn(black). Start: H7. Destination: H5. Chess piece can make a move
Type: pawn(white). Start: H2. Destination: H3. Chess piece can make a move
Type: queen. Start: C6. Destination: D10. The figure goes beyond the chessboard
Type: queen. Start: C6. Destination: K0. The figure goes beyond the chessboard
*/



