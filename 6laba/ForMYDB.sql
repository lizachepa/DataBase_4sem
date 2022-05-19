USE CEG_MyBase;

/*1. */
SELECT min(Стоимость)[Минимальная стоимость],
	   max(Стоимость)[Максимальная стоимость],
	   avg (Стоимость)[Средняя стоимость],
	   count(*)					[Общее кол-во товара],
	   sum(Стоимость)[Суммарная стоимость всех товаров]
FROM Товары

/*2. */
SELECT  Товары.Стоимость,
        max(Товары.Стоимость)[Максимальная вместимость],
		min(Товары.Стоимость)[Минимальная вместимость],
		avg(Товары.Стоимость)[Средняя вместимость],
		count(*)						   [Общее кол-во аудиторий данного типа],
	    sum(Товары.Стоимость)[Суммарная вместимость всех аудиторий]
FROM Товары Inner JOIN Заказы
ON Товары.Код_товара=Заказы.Код_товара
		 Group by Товары.Стоимость

/*3. */
SELECT *
FROM(SELECT CASE WHEN Количество_на_складе=300 THEN '300'
				WHEN Количество_на_складе BETWEEN 100 AND 200 THEN '100-200'
				WHEN Количество_на_складе BETWEEN 50 AND 99 THEN '50-99'
				WHEN Количество_на_складе BETWEEN 30 AND 49 THEN '30-49'
				ELSE 'Меньше 30'
				END[Количество товара],COUNT(*)[Количество]
FROM Товары GROUP BY CASE 
				WHEN Количество_на_складе BETWEEN 100 AND 200 THEN '100-200'
				WHEN Количество_на_складе BETWEEN 50 AND 99 THEN '50-99'
				WHEN Количество_на_складе BETWEEN 30 AND 49 THEN '30-49'
				ELSE 'Меньше 30'
				END)As T
					ORDER BY CASE[Количество товара]
					 WHEN '100-200' THEN 1
				WHEN '300'THEN 2
				WHEN '50-99' THEN 3
				WHEN '30-49' THEN 4
				ELSE 0
		END
/*
/*4.*/
SELECT п.Имя, п.Фамилия, з.Цена_продажи_товара_за_1_шт-т.Стоимость [Разница в цене], round(avg(cast(т.Количество_на_складе as float(4))),2) [Средняя количество]
FROM Заказы з inner join Товары т
	ON з.Код_товара=т.Код_товара
	Inner Join Покупатели п
		ON з.Код_покупателя=п.Код_покупателя	
Group by п.Имя,п.Фамилия
Order by [Средняя количество] Desc

/*
Переписать SELECT-запрос, разработанный в задании 4 так, чтобы в расчете среднего значения оценок использовались оценки только по дисциплинам с кодами БД и ОАиП. Использовать WHERE.*/

SELECT п.Имя, п.Фамилия, з.Цена_продажи_товара_за_1_шт-т.Стоимость [Разница в цене], round(avg(cast(т.Количество_на_складе as float(4))),2) [Средняя количество]
FROM Заказы з inner join Товары т
	ON з.Код_товара=т.Код_товара
	Inner Join Покупатели п
		ON з.Код_покупателя=п.Код_покупателя	
		where п.Имя='Анна'
Group by п.Имя,п.Фамилия
Order by [Средняя количество] Desc

/*
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
select a.SUBJECT,a.note,(select count(*)[Количество]
from PROGRESS b
where b.SUBJECT=a.SUBJECT
and b.NOTE=a.NOTE)
from PROGRESS a
group by a.SUBJECT,a.NOTE
having NOTE=8 or NOTE=9

*/