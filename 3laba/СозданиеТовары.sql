USE CEG_MyBase;
CREATE table Товары
(Код_товара int primary key,
Вид_товара nvarchar(50),
Наименование nvarchar(50),
Количество_на_складе int,
Единица_измерения nvarchar(5),
Стоимость money not null)