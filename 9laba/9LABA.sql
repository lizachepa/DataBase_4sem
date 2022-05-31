--Запрос 1
use UNIVER
exec sp_helpindex 'AUDITORIUM'
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PROGRESS'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex 'TEACHER'

create table #EXPLRE
(
TIND int,
TFIELD varchar(100)
);

set nocount on;
DECLARE @i int = 0;
while @i<1000
begin
INSERT #EXPLRE(TIND, TFIELD)
	values(FLOOR(20000*RAND()), REPLICATE('строка',10));
	if(@i % 100 = 0) print @i
	set @i = @i+1
end;

drop table #EXPLRE

SELECT * FROM #EXPLRE where TIND between 1500 and 2500 order by TIND 

checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  

CREATE clustered index #EXPLRE_CL on #EXPLRE(TIND asc)

--Запрос 2

CREATE table #EX
(    TKEY int, 
      CC int identity(1, 1),
      TF varchar(100)
);

DBCC DROPCLEANBUFFERS;  

  set nocount on;           
  declare @ii int = 0;
  while   @ii < 20000       -- добавление в таблицу 20000 строк
  begin
       INSERT #EX(TKEY, TF) values(floor(30000*RAND()), replicate('строка ', 10));
        set @ii = @ii + 1; 
  end;
  
  SELECT count(*)[количество строк] from #EX;
  SELECT * from #EX

  CREATE index #EX_NONCLU on #EX(TKEY, CC)
  drop index #EX_NONCLU on #EX

  select * from  #ex where  tkey > 1500 and  cc < 4500;  
  select * from  #ex order by  tkey, cc

  CREATE index #EX_NONCLU on #EX(TKEY, CC)
  SELECT * from  #EX where  TKEY = 556 and  CC > 3

  --Запрос 3
  drop index #EX_TKEY_X on #EX
  
  CREATE  index #EX_TKEY_X on #EX(TKEY) INCLUDE (CC)

  SELECT CC from #EX where TKEY>15000 

  --Запрос 4
  drop index #EX_WHERE on #EX
  CREATE  index #EX_WHERE on #EX(TKEY) where (TKEY>=15000 and TKEY < 20000);  
  begin
	SELECT TKEY from  #EX where TKEY between 5000 and 19999; 
	SELECT TKEY from  #EX where TKEY>15000 and  TKEY < 20000  
	SELECT TKEY from  #EX where TKEY=17000
  end;

  --Запрос 5
  drop index #EX_TKEY ON #EX

  CREATE index #EX_TKEY ON #EX(TKEY); 

  select * from #EX

  	use tempdb
	SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
		   FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
		   OBJECT_ID(N'#EX2'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
		   ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  
		   WHERE name is not null;

  INSERT top(10000) #EX(TKEY, TF) select TKEY, TF from #EX;

  ALTER index #EX_TKEY on #EX reorganize;

  ALTER index #EX_TKEY on #EX rebuild with (online = off);

  select avg_fragmentation_in_percent[Фрагментация(%)]
	from sys.dm_db_index_physical_stats(db_id(N'tempbd'),
	object_id(N'#EX'), null, null, null)

	--Запрос 6
	DROP index #EX_TKEY on #EX;
	CREATE index #EX_TKEY on #EX(TKEY) with (fillfactor = 65);
	INSERT top(5000)percent INTO #EX(TKEY, TF) 
	select * from #EX
	use tempdb
	SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
		   FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
		   OBJECT_ID(N'#EX2'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
		   ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  
		   WHERE name is not null;