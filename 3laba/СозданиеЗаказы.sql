USE CEG_MyBase;
CREATE TABLE ������
(�����_������ int primary key,
���_���������� int foreign key references 
								����������(���_����������),
���_������ int foreign key references 
								������(���_������),
����������_�����������_������ int,
����_�������_������_��_1_�� money,
����_�������� date,
�����_�������� nvarchar(50) )