use master  
create database CEG_bd on primary									--��������� �������� ������
( name = N'CEG_bd_mdf', filename = N'D:\MyBD\CEG_bd_mdf.mdf',	--���������� ��� �����, ��� ����� � ��
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),			--�������������� ������  �����, ������������ ������  ����� � ����������

( name = N'CEG_bd_ndf', filename = N'D:\MyBD\\CEG_bd_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1														--��������� �������� ������
( name = N'CEG_bd_fg1_1', filename = N'D:\MyBD\CEG_bd_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'CEG_bd_fg1_2', filename = N'D:\MyBD\CEG_bd_fgq-2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on																--������ ����������
( name = N'CEG_bd_log', filename=N'D:\MyBD\CEG_bd_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%)
go

USE CEG_bd;
create table ������
(    
�������� nvarchar(15) primary key,
���_������ varchar(50)
) ON FG1;
insert into ������(��������,���_������ )
            values  ('������','������'),
			('�������','�������'),
			('�������','�������'),
			('������','�����'),
			('��������','�����');