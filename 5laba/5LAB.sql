USE UNIVER;
/*1 сформировать список наименований кафедр (столбец PULPIT_NAME),
которые находятся на факультете (таблица FACULTY), обеспечивающем подготовку по специальности, в наименовании (столбец PROFESSION_ NAME) которого содержится слово технология или технологии.*/
/*некоррелируемый*/
SELECT PULPIT.PULPIT_NAME,FACULTY.FACULTY_NAME
FROM PULPIT,FACULTY
WHERE PULPIT.FACULTY=FACULTY.FACULTY AND
			PULPIT.FACULTY IN(SELECT PROFESSION.FACULTY FROM PROFESSION
												WHERE( PROFESSION_NAME LIKE '%технологии%' OR 
												PROFESSION_NAME LIKE '%технология%'))



/*2. Переписать запрос пункта 1 таким образом,чтобы тот же подзапрос был записан в конструкции INNER JOIN секции FROM внешнего запроса.
При этом результат выполнения запроса должен быть аналогичным результату исходного запроса. */

SELECT PULPIT.PULPIT_NAME, FACULTY.FACULTY_NAME
FROM PULPIT INNER JOIN FACULTY
ON PULPIT.FACULTY=FACULTY.FACULTY 
WHERE PULPIT.FACULTY In (SELECT PROFESSION.FACULTY FROM PROFESSION 
						WHERE (PROFESSION_NAME LIKE '%технология%' OR PROFESSION_NAME LIKE '%технологии%'))


/*3. Переписать запрос, реализующий 1 пункт без использования подзапроса. 
Примечание: использовать соединение INNER JOIN трех таблиц*/
SELECT Distinct PULPIT.PULPIT_NAME,FACULTY.FACULTY_NAME
FROM PULPIT INNER JOIN FACULTY
ON PULPIT.FACULTY=FACULTY.FACULTY
INNER JOIN PROFESSION
ON FACULTY.FACULTY=PROFESSION.FACULTY
WHERE(PROFESSION_NAME LIKE '%технологии%' OR
								PROFESSION_NAME LIKE '%технология%')

/*4. На основе таблицы AUDITORIUM сформировать список аудиторий самых больших вместимостей (столбец AUDI-TORIUM_CAPACITY) для каждого ти-па аудитории (AUDITORIUM_TYPE).
При этом результат следует отсортиро-вать в порядке убывания вместимости. Примечание: использовать коррелируе-мый подзапрос c секциями TOP и OR-DER BY. */
SELECT * FROM AUDITORIUM a
WHERE  AUDITORIUM_CAPACITY = (
	SELECT TOP(1) AUDITORIUM_CAPACITY FROM AUDITORIUM aa
	WHERE aa.AUDITORIUM_TYPE=a.AUDITORIUM_TYPE 
	ORDER BY AUDITORIUM_CAPACITY desc)
ORDER BY AUDITORIUM_CAPACITY desc

/*5. На основе таблиц FACULTY и PULPIT сформировать список наимено-ваний факультетов (столбец FACUL-TY_NAME) на котором нет ни одной кафедры (таблица PULPIT). 
Примеча-ние: использовать предикат EXISTS и коррелированный подзапрос. */
SELECT FACULTY.FACULTY_NAME [Факультеты без кафедр]
FROM FACULTY
WHERE not exists (SELECT * FROM PULPIT
WHERE PULPIT.FACULTY=FACULTY.FACULTY)

SELECT FACULTY.FACULTY_NAME [Факультеты с кафедрами]
FROM FACULTY
WHERE exists (SELECT * FROM PULPIT
WHERE PULPIT.FACULTY=FACULTY.FACULTY)

/*6. На основе таблицы PROGRESS сформировать строку, содержащую средние значения оценок (столбец NOTE) по дисциплинам, имеющим сле-дующие коды: ОАиП, БД и СУБД. 
Примечание: использовать три некоррелированных подзапроса в списке SELECT; в подзапросах применить агрегатные функции AVG. */
SELECT  top 1
	(select avg(NOTE) from PROGRESS
	where SUBJECT like 'БД')[БД],
	(select avg(NOTE) from PROGRESS
	where SUBJECT Like 'СУБД')[СУБД], 
	(select avg(NOTE) from PROGRESS
	where SUBJECT Like 'ОАиП')[ОАиП]
FROM PROGRESS

/*7. Разработать SELECT-запрос, демонстрирующий принцип применения ALL совместно с подзапросом.*/
SELECT IDSTUDENT,SUBJECT,NOTE FROM PROGRESS
WHERE PROGRESS.NOTE>= all(select NOTE from PROGRESS
								where NOTE>6)

/*8. Разработать SELECT-запрос, демонстрирующий принцип применения ANY совместно с подзапросом*/
SELECT IDSTUDENT,SUBJECT,NOTE FROM PROGRESS
WHERE PROGRESS.NOTE>=any (select NOTE from PROGRESS
								where NOTE>6)








