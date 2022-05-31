USE CEG_MyBase;

/*1. */
SELECT min(���������)[����������� ���������],
	   max(���������)[������������ ���������],
	   avg (���������)[������� ���������],
	   count(*)		[����� ���-�� ������],
	   sum(���������)[��������� ��������� ���� �������]
FROM ������

/*2. */
SELECT  ������.���������,
        max(������.���������)[������������ �����������],
		min(������.���������)[����������� �����������],
		avg(������.���������)[������� �����������],
		count(*)			[����� ���-�� ��������� ������� ����],
	    sum(������.���������)[��������� ����������� ���� ���������]
FROM ������ Inner JOIN ������
ON ������.���_������=������.���_������
		 Group by ������.���������

/*3. */
SELECT *
FROM(SELECT CASE 
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
				WHEN '50-99' THEN 2
				WHEN '30-49' THEN 3
				ELSE 0
		END
		

/*4.*/
SELECT �.���, �.�������, round(avg(cast(�.����������_��_������ as float(4))),2) [������� ����������]
FROM ������ � inner join ������ �
	ON �.���_������=�.���_������
	Inner Join ���������� �
		ON �.���_����������=�.���_����������
Group by �.���,�.�������
Order by [������� ����������] Desc


/*���������� SELECT-������, ������������� � ������� 4 ���, ����� � ������� �������� �������� ������ �������������� ������ ������ �� ����������� � ������ �� � ����. ������������ WHERE.*/

SELECT �.���, �.�������, round(avg(cast(�.����������_��_������ as float(4))),2) [������� ����������]
FROM ������ � inner join ������ �
	ON �.���_������=�.���_������
	Inner Join ���������� �
		ON �.���_����������=�.���_����������	
		where �.���='����'
Group by �.���,�.�������
Order by [������� ����������] Desc


/*5. �� ������ ������ FACULTY, GROUPS, STUDENT � PROGRESS ����������� SELECT-������, � ������� ��������� �������������, ���������� � ������� ������ ��� ����� ��������� �� ���������� ���. 
������������ ����������� �� ����� FACULTY, PROFESSION, SUBJECT.�������� � ������ ����������� ROLLUP � ���������������� ���������.*/
SELECT  �.���, �.�������, �.���������,�.����_��������
FROM ������ � inner join ������ �
ON �.���_������ = �.���_������
Inner Join ���������� �
ON �.���_���������� = �.���_����������
Group by ROLLUP (�.���, �.�������), �.����_��������,�.���������

/*6. ��������� �������� SELECT-������ �.5 � �������������� CUBE-�����������. ���������������� ���������.*/
SELECT  �.���, �.�������, �.���������,�.����_��������
FROM ������ � inner join ������ �
ON �.���_������ = �.���_������
Inner Join ���������� �
ON �.���_���������� = �.���_����������
Group by CUBE (�.���, �.�������), �.����_��������,�.���������


/*7. �� ������ ������ GROUPS, STUDENT � PROGRESS ����������� SELECT-������, � ������� ������������ ���������� ����� ���������.
� ������� ������ ���������� �������������, ����������, ������� ������ ��������� �� ���������� ���.
�������� ����������� ������, � ����-��� ������������ ���������� ����� ��������� �� ���������� ����.
���������� ���������� ���� �������� � �������������� ���������� UNION � UNION ALL. ��������� ����������. */
select  �.���, �.�������, �.����������_�����������_������
from ������ as � inner join ������ as �
on �.���_������=�.���_������
inner join ���������� as �
on �.���_����������=�.���_����������
where �.���='����'
group by �.���,�.�������,�.����������_�����������_������

select  �.���, �.�������, �.����������_�����������_������
from ������ as � inner join ������ as �
on �.���_������=�.���_������
inner join ���������� as �
on �.���_����������=�.���_����������
where �.���='�������'
group by �.���,�.�������,�.����������_�����������_������


select  �.���, �.�������, �.����������_�����������_������
from ������ as � inner join ������ as �
on �.���_������=�.���_������
inner join ���������� as �
on �.���_����������=�.���_����������
where �.���='����'
group by �.���,�.�������,�.����������_�����������_������

union 

select  �.���, �.�������, �.����������_�����������_������
from ������ as � inner join ������ as �
on �.���_������=�.���_������
inner join ���������� as �
on �.���_����������=�.���_����������
where �.���='�������'
group by �.���,�.�������,�.����������_�����������_������

select  �.���, �.�������, �.����������_�����������_������
from ������ as � inner join ������ as �
on �.���_������=�.���_������
inner join ���������� as �
on �.���_����������=�.���_����������
where �.���='����'
group by �.���,�.�������,�.����������_�����������_������

union all

select  �.���, �.�������, �.����������_�����������_������
from ������ as � inner join ������ as �
on �.���_������=�.���_������
inner join ���������� as �
on �.���_����������=�.���_����������
where �.���='�������'
group by �.���,�.�������,�.����������_�����������_������



/*8. �������� ����������� ���� �������� �����, ��������� � ���������� ���������� �������� ������ 8. ��������� ���������.
������������ �������� INTERSECT*/
select  �.���, �.�������, �.����������_�����������_������
from ������ as � inner join ������ as �
on �.���_������=�.���_������
inner join ���������� as �
on �.���_����������=�.���_����������
where �.���='����'
group by �.���,�.�������,�.����������_�����������_������

intersect

select  �.���, �.�������, �.����������_�����������_������
from ������ as � inner join ������ as �
on �.���_������=�.���_������
inner join ���������� as �
on �.���_����������=�.���_����������
where �.���='�������'
group by �.���,�.�������,�.����������_�����������_������

/*9. �������� ������� ����� ���������� �����, ��������� � ���������� �������� ������ 8. ��������� ���������. ������������ �������� EXCEPT.*/
select  �.���, �.�������, �.����������_�����������_������
from ������ as � inner join ������ as �
on �.���_������=�.���_������
inner join ���������� as �
on �.���_����������=�.���_����������
where �.���='����'
group by �.���,�.�������,�.����������_�����������_������

except

select  �.���, �.�������, �.����������_�����������_������
from ������ as � inner join ������ as �
on �.���_������=�.���_������
inner join ���������� as �
on �.���_����������=�.���_����������
where �.���='�������'
group by �.���,�.�������,�.����������_�����������_������

/*10*/
select �.���_������,�.�����_������,�.���_����������,(select count(*)[����������]
from ������ �
where �.�����_������=�.�����_������
and �.���_������=�.���_����������)
from ������ �
group by �.���_������,�.�����_������,�.���_����������
having ���_������=1 or ���_������=5