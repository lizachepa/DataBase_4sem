USE CEG_MyBase;

/*1. */
SELECT min(���������)[����������� ���������],
	   max(���������)[������������ ���������],
	   avg (���������)[������� ���������],
	   count(*)					[����� ���-�� ������],
	   sum(���������)[��������� ��������� ���� �������]
FROM ������

/*2. */
SELECT  ������.���������,
        max(������.���������)[������������ �����������],
		min(������.���������)[����������� �����������],
		avg(������.���������)[������� �����������],
		count(*)						   [����� ���-�� ��������� ������� ����],
	    sum(������.���������)[��������� ����������� ���� ���������]
FROM ������ Inner JOIN ������
ON ������.���_������=������.���_������
		 Group by ������.���������

/*3. */
SELECT *
FROM(SELECT CASE WHEN ����������_��_������=300 THEN '300'
				WHEN ����������_��_������ BETWEEN 100 AND 200 THEN '100-200'
				WHEN ����������_��_������ BETWEEN 50 AND 99 THEN '50-99'
				WHEN ����������_��_������ BETWEEN 30 AND 49 THEN '30-49'
				ELSE '������ 30'
				END[���������� ������],COUNT(*)[����������]
FROM ������ GROUP BY CASE 
				WHEN ����������_��_������ BETWEEN 100 AND 200 THEN '100-200'
				WHEN ����������_��_������ BETWEEN 50 AND 99 THEN '50-99'
				WHEN ����������_��_������ BETWEEN 30 AND 49 THEN '30-49'
				ELSE '������ 30'
				END)As T
					ORDER BY CASE[���������� ������]
					 WHEN '100-200' THEN 1
				WHEN '300'THEN 2
				WHEN '50-99' THEN 3
				WHEN '30-49' THEN 4
				ELSE 0
		END
/*
/*4.*/
SELECT �.���, �.�������, �.����_�������_������_��_1_��-�.��������� [������� � ����], round(avg(cast(�.����������_��_������ as float(4))),2) [������� ����������]
FROM ������ � inner join ������ �
	ON �.���_������=�.���_������
	Inner Join ���������� �
		ON �.���_����������=�.���_����������	
Group by �.���,�.�������
Order by [������� ����������] Desc

/*
���������� SELECT-������, ������������� � ������� 4 ���, ����� � ������� �������� �������� ������ �������������� ������ ������ �� ����������� � ������ �� � ����. ������������ WHERE.*/

SELECT �.���, �.�������, �.����_�������_������_��_1_��-�.��������� [������� � ����], round(avg(cast(�.����������_��_������ as float(4))),2) [������� ����������]
FROM ������ � inner join ������ �
	ON �.���_������=�.���_������
	Inner Join ���������� �
		ON �.���_����������=�.���_����������	
		where �.���='����'
Group by �.���,�.�������
Order by [������� ����������] Desc

/*
/*5. �� ������ ������ FACULTY, GROUPS, STUDENT � PROGRESS ����������� SELECT-������, � ������� ��������� �������������, ���������� � ������� ������ ��� ����� ��������� �� ���������� ���. 
������������ ����������� �� ����� FACULTY, PROFESSION, SUBJECT.�������� � ������ ����������� ROLLUP � ���������������� ���������.*/
SELECT  f.FACULTY [���������],g.PROFESSION [�������������],p.SUBJECT [�������],round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
FROM FACULTY f inner join GROUPS g
ON f.FACULTY = g.FACULTY
Inner Join STUDENT s
ON s.IDGROUP = g.IDGROUP
Inner Join PROGRESS p
ON p.IDSTUDENT = s.IDSTUDENT
Group by ROLLUP (g.PROFESSION, p.SUBJECT), f.FACULTY;

/*6. ��������� �������� SELECT-������ �.5 � �������������� CUBE-�����������. ���������������� ���������.*/
SELECT  f.FACULTY [���������],g.PROFESSION [�������������],p.SUBJECT [�������],round(avg(cast(p.NOTE as float(4))), 2) [������� ������]
FROM FACULTY f inner join GROUPS g
ON f.FACULTY = g.FACULTY
Inner Join STUDENT s
ON s.IDGROUP = g.IDGROUP
Inner Join PROGRESS p
ON p.IDSTUDENT = s.IDSTUDENT
Group by CUBE (g.PROFESSION, p.SUBJECT), f.FACULTY;

/*7. �� ������ ������ GROUPS, STUDENT � PROGRESS ����������� SELECT-������, � ������� ������������ ���������� ����� ���������.
� ������� ������ ���������� �������������, ����������, ������� ������ ��������� �� ���������� ���.
�������� ����������� ������, � ����-��� ������������ ���������� ����� ��������� �� ���������� ����.
���������� ���������� ���� �������� � �������������� ���������� UNION � UNION ALL. ��������� ����������. */
select  FACULTY [���������],PROFESSION [�������������], SUBJECT [�������], round(avg(cast(p.NOTE as float(4))), 2) [������]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = '����'
group by FACULTY, PROFESSION, SUBJECT

select  FACULTY [���������],PROFESSION [�������������], SUBJECT [�������], round(avg(cast(p.NOTE as float(4))), 2) [������]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = '���'
group by FACULTY, PROFESSION, SUBJECT

select  FACULTY [���������],PROFESSION [�������������], SUBJECT [�������], round(avg(cast(p.NOTE as float(4))), 2) [������]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = '����'
group by FACULTY, PROFESSION, SUBJECT

UNION

select  FACULTY [���������],PROFESSION [�������������], SUBJECT [�������], round(avg(cast(p.NOTE as float(4))), 2) [������]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = '���'
group by FACULTY, PROFESSION, SUBJECT

select  FACULTY [���������],PROFESSION [�������������], SUBJECT [�������], round(avg(cast(p.NOTE as float(4))), 2) [������]
from PROGRESS p inner join STUDENT s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = '����'
group by FACULTY, PROFESSION, SUBJECT

UNION ALL

select  FACULTY [���������],PROFESSION [�������������], SUBJECT [�������], round(avg(cast(p.NOTE as float(4))), 2) [������]
from PROGRESS p inner join STUDENT s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = '���'
group by FACULTY, PROFESSION, SUBJECT


/*8. �������� ����������� ���� �������� �����, ��������� � ���������� ���������� �������� ������ 8. ��������� ���������.
������������ �������� INTERSECT*/
select  FACULTY [���������],PROFESSION [�������������], SUBJECT [�������], round(avg(cast(p.NOTE as float(4))), 2) [������]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP

where g.FACULTY = '����'
group by FACULTY, PROFESSION, SUBJECT

INTERSECT	

select  FACULTY [���������],PROFESSION [�������������], SUBJECT [�������], round(avg(cast(p.NOTE as float(4))), 2) [������]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = '���'
group by FACULTY, PROFESSION, SUBJECT

/*9. �������� ������� ����� ���������� �����, ��������� � ���������� �������� ������ 8. ��������� ���������. ������������ �������� EXCEPT.*/
select  FACULTY [���������],PROFESSION [�������������], SUBJECT [�������], round(avg(cast(p.NOTE as float(4))), 2) [������]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP

where g.FACULTY = '����'
group by FACULTY, PROFESSION, SUBJECT

EXCEPT	

select  FACULTY [���������],PROFESSION [�������������], SUBJECT [�������], round(avg(cast(p.NOTE as float(4))), 2) [������]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = '���'
group by FACULTY, PROFESSION, SUBJECT

/*10*/
select a.SUBJECT,a.note,(select count(*)[����������]
from PROGRESS b
where b.SUBJECT=a.SUBJECT
and b.NOTE=a.NOTE)
from PROGRESS a
group by a.SUBJECT,a.NOTE
having NOTE=8 or NOTE=9

*/