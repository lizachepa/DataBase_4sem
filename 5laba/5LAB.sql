USE UNIVER;
/*1 ������������ ������ ������������ ������ (������� PULPIT_NAME),
������� ��������� �� ���������� (������� FACULTY), �������������� ���������� �� �������������, � ������������ (������� PROFESSION_ NAME) �������� ���������� ����� ���������� ��� ����������.*/
/*���������������*/
SELECT PULPIT.PULPIT_NAME,FACULTY.FACULTY_NAME
FROM PULPIT,FACULTY
WHERE PULPIT.FACULTY=FACULTY.FACULTY AND
			PULPIT.FACULTY IN(SELECT PROFESSION.FACULTY FROM PROFESSION
												WHERE( PROFESSION_NAME LIKE '%����������%' OR 
												PROFESSION_NAME LIKE '%����������%'))



/*2. ���������� ������ ������ 1 ����� �������,����� ��� �� ��������� ��� ������� � ����������� INNER JOIN ������ FROM �������� �������.
��� ���� ��������� ���������� ������� ������ ���� ����������� ���������� ��������� �������. */

SELECT PULPIT.PULPIT_NAME, FACULTY.FACULTY_NAME
FROM PULPIT INNER JOIN FACULTY
ON PULPIT.FACULTY=FACULTY.FACULTY 
WHERE PULPIT.FACULTY In (SELECT PROFESSION.FACULTY FROM PROFESSION 
						WHERE (PROFESSION_NAME LIKE '%����������%' OR PROFESSION_NAME LIKE '%����������%'))


/*3. ���������� ������, ����������� 1 ����� ��� ������������� ����������. 
����������: ������������ ���������� INNER JOIN ���� ������*/
SELECT Distinct PULPIT.PULPIT_NAME,FACULTY.FACULTY_NAME
FROM PULPIT INNER JOIN FACULTY
ON PULPIT.FACULTY=FACULTY.FACULTY
INNER JOIN PROFESSION
ON FACULTY.FACULTY=PROFESSION.FACULTY
WHERE(PROFESSION_NAME LIKE '%����������%' OR
								PROFESSION_NAME LIKE '%����������%')

/*4. �� ������ ������� AUDITORIUM ������������ ������ ��������� ����� ������� ������������ (������� AUDI-TORIUM_CAPACITY) ��� ������� ��-�� ��������� (AUDITORIUM_TYPE).
��� ���� ��������� ������� ���������-���� � ������� �������� �����������. ����������: ������������ ����������-��� ��������� c �������� TOP � OR-DER BY. */
SELECT * FROM AUDITORIUM a
WHERE  AUDITORIUM_CAPACITY = (
	SELECT TOP(1) AUDITORIUM_CAPACITY FROM AUDITORIUM aa
	WHERE aa.AUDITORIUM_TYPE=a.AUDITORIUM_TYPE 
	ORDER BY AUDITORIUM_CAPACITY desc)
ORDER BY AUDITORIUM_CAPACITY desc

/*5. �� ������ ������ FACULTY � PULPIT ������������ ������ �������-����� ����������� (������� FACUL-TY_NAME) �� ������� ��� �� ����� ������� (������� PULPIT). 
�������-���: ������������ �������� EXISTS � ��������������� ���������. */
SELECT FACULTY.FACULTY_NAME [���������� ��� ������]
FROM FACULTY
WHERE not exists (SELECT * FROM PULPIT
WHERE PULPIT.FACULTY=FACULTY.FACULTY)

SELECT FACULTY.FACULTY_NAME [���������� � ���������]
FROM FACULTY
WHERE exists (SELECT * FROM PULPIT
WHERE PULPIT.FACULTY=FACULTY.FACULTY)

/*6. �� ������ ������� PROGRESS ������������ ������, ���������� ������� �������� ������ (������� NOTE) �� �����������, ������� ���-������ ����: ����, �� � ����. 
����������: ������������ ��� ����������������� ���������� � ������ SELECT; � ����������� ��������� ���������� ������� AVG. */
SELECT  top 1
	(select avg(NOTE) from PROGRESS
	where SUBJECT like '��')[��],
	(select avg(NOTE) from PROGRESS
	where SUBJECT Like '����')[����], 
	(select avg(NOTE) from PROGRESS
	where SUBJECT Like '����')[����]
FROM PROGRESS

/*7. ����������� SELECT-������, ��������������� ������� ���������� ALL ��������� � �����������.*/
SELECT IDSTUDENT,SUBJECT,NOTE FROM PROGRESS
WHERE PROGRESS.NOTE>= all(select NOTE from PROGRESS
								where NOTE>6)

/*8. ����������� SELECT-������, ��������������� ������� ���������� ANY ��������� � �����������*/
SELECT IDSTUDENT,SUBJECT,NOTE FROM PROGRESS
WHERE PROGRESS.NOTE>=any (select NOTE from PROGRESS
								where NOTE>6)








