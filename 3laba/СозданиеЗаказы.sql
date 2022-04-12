USE CEG_MyBase;
CREATE TABLE Заказы
(Номер_заказа int primary key,
Код_покупателя int foreign key references 
								Покупатели(Код_покупателя),
Код_товара int foreign key references 
								Товары(Код_товара),
Количество_заказанного_товара int,
Цена_продажи_товара_за_1_шт money,
Дата_поставки date,
Адрес_доставки nvarchar(50) )