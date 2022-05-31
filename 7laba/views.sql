--use UNIVER;

/*1. Разработать представление с именем Преподаватель. Представление должно быть построено на основе SELECT-запроса к таб-лице TEACHER и содержать следующие столбцы: код (TEACHER), 
имя преподава-теля (TEACHER_NAME), пол (GENDER), код кафедры (PULPIT). */
/*select t.TEACHER,t.TEACHER_NAME,t.GENDER,t.PULPIT
from TEACHER t*/
/*
CREATE VIEW[Преподаватель]
as select TEACHER[код],
TEACHER_NAME[имя преподавателя],
GENDER[пол],
PULPIT[код кафедры]
from TEACHER 
*/
/*
/*2. Разработать и создать представление с именем Количество кафедр. Представление должно быть построено на основе SELECT-запроса к таблицам FACULTY и PULPIT.
Представление должно содержать следующие столбцы: факультет (FACULTY.FACULTY_ NAME), количество кафедр (вычисляется на основе строк таблицы PULPIT).*/

create view[Количество кафедр]
as select f.FACULTY_NAME[факультет],
count(*) p.PULPIT_NAME [количество кафедр]
from FACULTY f join PULPIT p
on f.FACULTY=p.FACULTY
*/
/*3. Разработать и создать представление с именем Аудитории. Представление должно быть построено на основе таблицы AUDI-TORIUM и содержать столбцы: код (AUDI-TORIUM), наименование аудитории (AU-DITORIUM_NAME). 
Представление должно отображать только лекционные аудитории (в столбце AUDITO-RIUM_ TYPE строка, начинающаяся с сим-вола ЛК) и допускать выполнение оператора INSERT, UPDATE и DELETE.*/
/*
CREATE VIEW [АУДИТОРИИ]
AS SELECT A.AUDITORIUM[код],
A.AUDITORIUM_NAME [наименование аудитории]
FROM AUDITORIUM A
WHERE A.AUDITORIUM_NAME LIKE '%ЛК%';
GO 
SELECT * FROM АУДИТОРИИ
*//*
INSERT АУДИТОРИИ VALUES(100,'ЛК')
INSERT АУДИТОРИИ VALUES(1000,'ЛК')*/
/*4. Разработать и создать представление с именем Лекционные_аудитории. 
Представление должно быть построено на основе SELECT-запроса к таблице AUDI-TORIUM и содержать следующие столбцы: код (AUDITORIUM), наименование ауди-тории (AUDITORIUM_NAME). 
Представление должно отображать только лекционные аудитории (в столбце AUDITO-RIUM_TYPE строка, начинающаяся с сим-волов ЛК). 
Выполнение INSERT и UPDATE допуска-ется, но с учетом ограничения, задаваемого опцией WITH CHECK OPTION.*/

/*5*/
/*
create view Дисциплины
as
select top 50
s.SUBJECT [Код], s.SUBJECT_NAME [Наименование дисциплины], s.PULPIT [Кафедра]
from SUBJECT s
order by Код
*/
/*6*/
/*go
ALTER VIEW [Колличество кафедр] with SCHEMABINDING
as select fclt.FACULTY_NAME  [Факультет],
   count(plpt.PULPIT)  [Количество_кафедр]
        from dbo.FACULTY fclt inner join dbo.PULPIT plpt
        on fclt.FACULTY = plpt.FACULTY group by FACULTY_NAME;
*/
select * from [Колличество кафедр];