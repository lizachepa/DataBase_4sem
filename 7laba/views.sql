--use UNIVER;

/*1. ����������� ������������� � ������ �������������. ������������� ������ ���� ��������� �� ������ SELECT-������� � ���-���� TEACHER � ��������� ��������� �������: ��� (TEACHER), 
��� ���������-���� (TEACHER_NAME), ��� (GENDER), ��� ������� (PULPIT). */
/*select t.TEACHER,t.TEACHER_NAME,t.GENDER,t.PULPIT
from TEACHER t*/
/*
CREATE VIEW[�������������]
as select TEACHER[���],
TEACHER_NAME[��� �������������],
GENDER[���],
PULPIT[��� �������]
from TEACHER 

/*2. ����������� � ������� ������������� � ������ ���������� ������. ������������� ������ ���� ��������� �� ������ SELECT-������� � �������� FACULTY � PULPIT.
������������� ������ ��������� �����-���� �������: ��������� (FACUL-TY.FACULTY_ NAME), ���������� ��-���� (����������� �� ������ ����� ������� PULPIT). 
*/
create view[���������� ������]
as select FACULTY.FACULTY_NAME[���������],
count(*) PULPIT.PULPIT_NAME [���������� ������]
from FACULTY join PULPIT
on FACULTY.FACULTY=PULPIT.FACULTY
*/
/*3. ����������� � ������� ������������� � ������ ���������. ������������� ������ ���� ��������� �� ������ ������� AUDI-TORIUM � ��������� �������: ��� (AUDI-TORIUM), ������������ ��������� (AU-DITORIUM_NAME). 
������������� ������ ���������� ������ ���������� ��������� (� ������� AUDITO-RIUM_ TYPE ������, ������������ � ���-���� ��) � ��������� ���������� ��������� INSERT, UPDATE � DELETE.
*//*
CREATE VIEW [���������]
AS SELECT A.AUDITORIUM[���],
A.AUDITORIUM_NAME [������������ ���������]
FROM AUDITORIUM A
WHERE A.AUDITORIUM_NAME LIKE '%��%';
GO 
SELECT * FROM ���������
*//*
INSERT ��������� VALUES(100,'��')
INSERT ��������� VALUES(1000,'��')*/
/*4. ����������� � ������� ������������� � ������ ����������_���������. 
������������� ������ ���� ��������� �� ������ SELECT-������� � ������� AUDI-TORIUM � ��������� ��������� �������: ��� (AUDITORIUM), ������������ ����-����� (AUDITORIUM_NAME). 
������������� ������ ���������� ������ ���������� ��������� (� ������� AUDITO-RIUM_TYPE ������, ������������ � ���-����� ��). 
���������� INSERT � UPDATE �������-����, �� � ������ �����������, ����������� ������ WITH CHECK OPTION. 
*/
