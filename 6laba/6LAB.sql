USE UNIVER;

/*1. На основе таблицы AUDITORIUM разработать SELECT-запрос, вычисляю-щий максимальную,
минимальную и среднюю вместимость аудиторий, сум-марную вместимость всех аудиторий и общее количество аудиторий. */
SELECT min(AUDITORIUM_CAPACITY)[Минимальная вместимость],
	   max(AUDITORIUM_CAPACITY)[Максимальная вместимость],
	   avg (AUDITORIUM_CAPACITY)[Средняя вместимость],
	   count(*)					[Общее кол-во аудиторий],
	   sum(AUDITORIUM_CAPACITY)[Суммарная вместимость всех аудиторий]
FROM AUDITORIUM

/*2. На основе таблиц AUDITORIUM и AUDITORIUM_TYPE разработать за-прос, вычисляющий для каждого типа аудиторий максимальную, минимальную, среднюю вместимость аудиторий,
сум-марную вместимость всех аудиторий и общее количество аудиторий данного ти-па. 
Результирующий набор должен содер-жать столбец с наименованием типа ауди-торий (столбец AUDITORI-UM_TYPE.AU-DITORIUM_TYPENAME) и 
столбцы с вычисленными величинами. Использовать внутреннее соединение таблиц, секцию GROUP BY и агрегатные функции. */
SELECT  AUDITORIUM_TYPE.AUDITORIUM_TYPENAME[Тип аудитории],
        max(AUDITORIUM.AUDITORIUM_CAPACITY)[Максимальная вместимость],
		min(AUDITORIUM.AUDITORIUM_CAPACITY)[Минимальная вместимость],
		avg(AUDITORIUM.AUDITORIUM_CAPACITY)[Средняя вместимость],
		count(*)						   [Общее кол-во аудиторий данного типа],
	    sum(AUDITORIUM.AUDITORIUM_CAPACITY)[Суммарная вместимость всех аудиторий]
FROM AUDITORIUM_TYPE Inner JOIN AUDITORIUM
ON AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
		 Group by AUDITORIUM_TYPE.AUDITORIUM_TYPENAME

/*3. Разработать запрос на основе таблицы PROGRESS, который содержит количество экзаменационных оценок в заданном интервале. 
При этом учесть, что сортировка строк должна осуществляться в порядке, обратном величине оценки; сумма значений в столбце количество должна быть равна количеству строк в таблице PROGRESS. 
Использовать подзапрос в секции FROM, в подзапросе применить GROUP BY, сортировку осуществить во внешнем запросе. В секции GROUP BY, в SELECT-списке подзапроса и в ORDER BY внешнего запроса применить CASE.*/
SELECT *
FROM(SELECT CASE WHEN NOTE=10 THEN '10'
				WHEN NOTE BETWEEN 8 AND 9 THEN '8-9'
				WHEN NOTE BETWEEN 6 AND 7 THEN '6-7'
				WHEN NOTE BETWEEN 4 AND 5 THEN '4-5'
				ELSE 'Оценка ниже 4'
				END[Оценки],COUNT(*)[Количество]
FROM PROGRESS GROUP BY CASE 
				WHEN NOTE=10 THEN '10'
				WHEN NOTE BETWEEN 8 AND 9 THEN '8-9'
				WHEN NOTE BETWEEN 6 AND 7 THEN '6-7'
				WHEN NOTE BETWEEN 4 AND 5 THEN '4-5'
				ELSE 'Оценка ниже 4'
				END)As T
					ORDER BY CASE[Оценки]
					 WHEN '10' THEN 1
				WHEN '8-9'THEN 2
				WHEN '6-7' THEN 3
				WHEN '4-5' THEN 4
				ELSE 0
				END

/*4. Разработать SELECT-запроса на основе таблиц FACULTY, GROUPS, STUDENT и PROGRESS, который содержит среднюю экзаменационную оценку для каждого курса каждой специальности. 
Строки отсортировать в порядке убывания средней оценки.*/
SELECT f.FACULTY[Факультет], g.PROFESSION[Специальность], 2014 - g.YEAR_FIRST [Курс], round(avg(cast(p.NOTE as float(4))),2) [Средняя оценка]
FROM FACULTY f inner join GROUPS g
	ON f.FACULTY=g.FACULTY
	Inner Join STUDENT s
		ON g.IDGROUP=s.IDGROUP
			Inner Join PROGRESS p
				ON p.IDSTUDENT=s.IDSTUDENT
Group by f.FACULTY, g.PROFESSION, g.YEAR_FIRST
Order by [Средняя оценка] Desc

/*
Переписать SELECT-запрос, разработанный в задании 4 так, чтобы в расчете среднего значения оценок использовались оценки только по дисциплинам с кодами БД и ОАиП. Использовать WHERE.*/


SELECT f.FACULTY[Факультет], g.PROFESSION[Специальность], 2014 - g.YEAR_FIRST [Курс], round(avg(cast(p.NOTE as float(4))),2) [Средняя оценка]
FROM FACULTY f inner join GROUPS g
	ON f.FACULTY=g.FACULTY
	Inner Join STUDENT s
		ON g.IDGROUP=s.IDGROUP
			Inner Join PROGRESS p
				ON p.IDSTUDENT=s.IDSTUDENT
WHERE p.SUBJECT='ОАиП' or p.SUBJECT='БД'		
Group by f.FACULTY, g.PROFESSION, g.YEAR_FIRST
Order by [Средняя оценка] Desc

/*5. На основе таблиц FACULTY, GROUPS, STUDENT и PROGRESS разработать SELECT-запрос, в котором выводятся специальность, дисциплины и средние оценки при сдаче экзаменов на факультете ТОВ. 
Использовать группировку по полям FACULTY, PROFESSION, SUBJECT.Добавить в запрос конструкцию ROLLUP и проанализировать результат.*/
SELECT  f.FACULTY [Факультет],g.PROFESSION [Специальность],p.SUBJECT [Предмет],round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
FROM FACULTY f inner join GROUPS g
ON f.FACULTY = g.FACULTY
Inner Join STUDENT s
ON s.IDGROUP = g.IDGROUP
Inner Join PROGRESS p
ON p.IDSTUDENT = s.IDSTUDENT
Group by ROLLUP (g.PROFESSION, p.SUBJECT), f.FACULTY;

/*6. Выполнить исходный SELECT-запрос п.5 с использованием CUBE-группировки. Проанализировать результат.*/
SELECT  f.FACULTY [Факультет],g.PROFESSION [Специальность],p.SUBJECT [Предмет],round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
FROM FACULTY f inner join GROUPS g
ON f.FACULTY = g.FACULTY
Inner Join STUDENT s
ON s.IDGROUP = g.IDGROUP
Inner Join PROGRESS p
ON p.IDSTUDENT = s.IDSTUDENT
Group by CUBE (g.PROFESSION, p.SUBJECT), f.FACULTY;

/*7. На основе таблиц GROUPS, STUDENT и PROGRESS разработать SELECT-запрос, в котором определяются результаты сдачи экзаменов.
В запросе должны отражаться специальности, дисциплины, средние оценки студентов на факультете ТОВ.
Отдельно разработать запрос, в кото-ром определяются результаты сдачи экзаменов на факультете ХТиТ.
Объединить результаты двух запросов с использованием операторов UNION и UNION ALL. Объяснить результаты. */
select  FACULTY [факультет],PROFESSION [Специальность], SUBJECT [Предмет], round(avg(cast(p.NOTE as float(4))), 2) [Оценка]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = 'ХТиТ'
group by FACULTY, PROFESSION, SUBJECT

select  FACULTY [факультет],PROFESSION [Специальность], SUBJECT [Предмет], round(avg(cast(p.NOTE as float(4))), 2) [Оценка]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = 'ТОВ'
group by FACULTY, PROFESSION, SUBJECT

select  FACULTY [Факультет],PROFESSION [Специальность], SUBJECT [Предмет], round(avg(cast(p.NOTE as float(4))), 2) [Оценка]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = 'ХТиТ'
group by FACULTY, PROFESSION, SUBJECT

UNION

select  FACULTY [Факультет],PROFESSION [Специальность], SUBJECT [Предмет], round(avg(cast(p.NOTE as float(4))), 2) [Оценка]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = 'ТОВ'
group by FACULTY, PROFESSION, SUBJECT

select  FACULTY [Факультет],PROFESSION [Специальность], SUBJECT [Предмет], round(avg(cast(p.NOTE as float(4))), 2) [Оценка]
from PROGRESS p inner join STUDENT s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = 'ХТиТ'
group by FACULTY, PROFESSION, SUBJECT

UNION ALL

select  FACULTY [Факультет],PROFESSION [Специальность], SUBJECT [Предмет], round(avg(cast(p.NOTE as float(4))), 2) [Оценка]
from PROGRESS p inner join STUDENT s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = 'ТОВ'
group by FACULTY, PROFESSION, SUBJECT


/*8. Получить пересечение двух множеств строк, созданных в результате выполнения запросов пункта 8. Объяснить результат.
Использовать оператор INTERSECT*/
select  FACULTY [Факультет],PROFESSION [Специальность], SUBJECT [Предмет], round(avg(cast(p.NOTE as float(4))), 2) [Оценка]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP

where g.FACULTY = 'ХТиТ'
group by FACULTY, PROFESSION, SUBJECT

INTERSECT	

select  FACULTY [Факультет],PROFESSION [Специальность], SUBJECT [Предмет], round(avg(cast(p.NOTE as float(4))), 2) [Оценка]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = 'ТОВ'
group by FACULTY, PROFESSION, SUBJECT

/*9. Получить разницу между множеством строк, созданных в результате запросов пункта 8. Объяснить результат. Использовать оператор EXCEPT.*/
select  FACULTY [Факультет],PROFESSION [Специальность], SUBJECT [Предмет], round(avg(cast(p.NOTE as float(4))), 2) [Оценка]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP

where g.FACULTY = 'ХТиТ'
group by FACULTY, PROFESSION, SUBJECT

EXCEPT	

select  FACULTY [Факультет],PROFESSION [Специальность], SUBJECT [Предмет], round(avg(cast(p.NOTE as float(4))), 2) [Оценка]
from PROGRESS as p inner join STUDENT as s
on p.IDSTUDENT = s.IDSTUDENT
inner join GROUPS as g
on g.IDGROUP = s.IDGROUP
where g.FACULTY = 'ТОВ'
group by FACULTY, PROFESSION, SUBJECT

/*10*/
select a.SUBJECT[Предмет],a.note[Оценка],(select count(*)[Количество]
from PROGRESS b
where b.SUBJECT=a.SUBJECT
and b.NOTE=a.NOTE)
from PROGRESS a
group by a.SUBJECT,a.NOTE
having NOTE=8 or NOTE=9


