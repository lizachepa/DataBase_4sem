USE CEG_MyBase;
CREATE TABLE Покупатели
(Код_покупателя int primary key,
Фамилия nvarchar(50),
Имя nvarchar(50),
Отчество nvarchar(50),
Телефон nchar(7),
Эмэйл nvarchar(50),
Дата_рождения date,
Признак_скидки nchar(1) )