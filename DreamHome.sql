
--����¹��� system Database Master
USE master
GO
--��Ǩ�ͺ����ժ��ͫ�ӡѹ������� ��������ź�͡
if exists (select * from sysdatabases where name = 'DreamHome')
	drop database DreamHome
go
--���ҧ Database ���� DreamHome
create database DreamHome

--����������
Alter Database DreamHome Collate Thai_CI_AS
go

SET DATEFORMAT dmy
GO
--����¹��� DreamHome
use DreamHome
go
--���ҧ���ҧ������
create table BRANCH(
	BranchNo	char (4),
	Street		varchar (25),
	City		varchar (15),
	Postcode	char (5),
	primary key (BranchNo));
go
create table EMPLOYEE(
	EmpNo		int identity(1,1),
	EmpName		varchar (30),
	Position	varchar (20),
	Sex			char (1),
	BirthDate	datetime,
	Salary		money,
	BranchNo	char (4),
	primary key (EmpNo),
	foreign key (BranchNo) references BRANCH(BranchNo)on update cascade);
go
create table OWNER(
	OwnerNo		int identity(1,1),
	OwnerName	varchar(30),
	Address		varchar (30),
	TelNo		varchar(20),
	primary key (OwnerNo));
go
create table CLIENT(
	ClientNo	int identity(1,1),
	ClientName	varchar (30),
	TelNo		varchar (20),
	PrefType	varchar(10),
	MaxRent		money ,
	primary key (ClientNo));
go
create table PROPERTY(
	PropertyNo	int identity(1,1),
	Street		varchar (25),
	City		varchar (15),
	PostCode	char (5),
	Type		varchar (10),
	Rooms		int,
	RentRate	money,
	OwnerNo		int,
	EmpNo		int,
	primary key (PropertyNo),
	foreign key (OwnerNo)	references Owner(OwnerNo),
	foreign key (EmpNo)		references Employee(EmpNo));
go
create table VIEWING(
	ClientNo	int,
	ViewDate	datetime,
	PropertyNo	int,
	Comment		varchar(30),	
	primary	key (ClientNo,ViewDate),
	foreign key (ClientNo) references Client(ClientNo)on update cascade,
	foreign key (PropertyNo) references property(PropertyNo)on update cascade);
go
--����������㹵��ҧ BRANCH
INSERT INTO Branch  VALUES('B005','21 �.�������','��§����','50300')
INSERT INTO Branch  VALUES('B007','56 �.����¸Թ','��ɳ��š','65150')
INSERT INTO Branch  VALUES('B003','143 �.����Ǵ��ѧ�Ե','��ا෾�','10110')
INSERT INTO Branch  VALUES('B004','22 �.���Ե�','��§���','57000')
INSERT INTO Branch  VALUES('B002','11 �.����¸Թ','��§����','50300')
go
select * from BRANCH
--����������㹵��ҧ EMPLOYEE
INSERT INTO Employee  VALUES('�����෾ �ش����','���Ѵ���','M','11/11/1987',30000,'B005')
INSERT INTO Employee  VALUES('��¨�ؾ� �Ф�','������','F','15/8/1988',12000,'B003')
INSERT INTO Employee  VALUES('�ҧ������� ����������','�ػ����������','M','23/7/1985',18000,'B003')
INSERT INTO Employee  VALUES('����ط���ѡɳ� ����ʧ','������','F','22/7/1985',9000,'B007')
INSERT INTO Employee  VALUES('��¸��� �پش��','���Ѵ���','F','6/2/1980',24000,'B003')
INSERT INTO Employee  VALUES('�ҧ������� ����ح���ͧ','������','F','31/8/1987',9000,'B005')
go
select * from Employee
--����������㹵��ҧ OWNER
INSERT INTO Owner  VALUES('�ҧ������س� ����Թ','��ɳ��š','02-149741')
INSERT INTO Owner  VALUES('����Է�Ԫ�� �ح�ҡ','��ا෾�','02-3916105')
INSERT INTO Owner  VALUES('�ҧ���͹ѹ��ó� �ح��','��ا෾�','02-2208904')
INSERT INTO Owner  VALUES('����Ѳ�� ����ѧ���','��ا෾�','02-7844718')
INSERT INTO Owner  VALUES('��¡Ե�ԡó� ྪù���','��§����','02-8580711')
INSERT INTO Owner  VALUES('�ҧ�������ѵ�� ���ҧ�кص�','�شøҹ�','02-6213413')
INSERT INTO Owner  VALUES('�ҧ��������ѵ�� �ط���','˹ͧ���','02-2139468')
INSERT INTO Owner  VALUES('�ҧ��ǡѭ���ѵ�� �ҵ�','��ا෾�','02-9027607')
INSERT INTO Owner  VALUES('��¨���Ѳ�� �ʹ�Է���','��§����','02-4017713')
INSERT INTO Owner  VALUES('�ҧ��ǡ�õ� ���������','�شøҹ�','02-7422635')
INSERT INTO Owner  VALUES('�ҧ���Ŵ������ ൹�ǧ��','˹ͧ���','02-824046')
INSERT INTO Owner  VALUES('�ҧ��������� ⤵þ����','�شøҹ�','02-7076622')
INSERT INTO Owner  VALUES('�ҧ����ؾѵ��� ��������','˹ͧ���','02-1258381')
INSERT INTO Owner  VALUES('�ҧ��ǡҭ��� ���¾���','��ا෾�','02-589142')
INSERT INTO Owner  VALUES('�ҧ������ԡ�� �ѹ�ҪԹ','�شøҹ�','02-1250134')
INSERT INTO Owner  VALUES('�ҧ��ǹب�� ��ǹ����','��ا෾�','02-4955327')
INSERT INTO Owner  VALUES('�ҧ���������� ���','��ا෾�','02-2967681')
INSERT INTO Owner  VALUES('��»�Шѡ�� ǧ����','˹ͧ���','02-9767122')
go
select * from owner
--����������㹵��ҧ CLIENT
INSERT INTO Client  VALUES('��¾�� �Ӿ����','02-5556677','�ŵ',425)
INSERT INTO Client  VALUES('����ѧ��ä� �ԧ˸���','02-4433556','�ŵ',350)
INSERT INTO Client  VALUES('�ҧ������Թѹ�� ������','02-5556699','��ҹ',750)
INSERT INTO Client  VALUES('����ҷԵ�� �Է���������','02-3334455','�ŵ',600)
INSERT INTO Client  VALUES('�ҧ�����Դ� �ըѹ��','02-5306182','�ŵ',400)
INSERT INTO Client  VALUES('��¨��ç�� ���ԧ��','02-6196171','�ŵ',370)
INSERT INTO Client  VALUES('��·ç�ز� �ص�⤵�','02-4963656','��ҹ',310)
INSERT INTO Client  VALUES('�����ʴ� ⾸����','02-6226452','�ŵ',360)
INSERT INTO Client  VALUES('��������ѡ��� ���������','02-4201947','�ŵ',680)
INSERT INTO Client  VALUES('��¸ҹԹ��� �ش����','02-7035896','�ŵ',590)
INSERT INTO Client  VALUES('��»���ط� ����⤵�','02-755153','��ҹ',670)
INSERT INTO Client  VALUES('��»�Ե� �����ѵ��','02-3511088','�ŵ',360)
INSERT INTO Client  VALUES('�ҧ��Ǵ�ó� ���Ԫ��','02-5051798','��ҹ',870)
INSERT INTO Client  VALUES('�����ѳ�� �������','02-4838751','�ŵ',390)
INSERT INTO Client  VALUES('������õ��ѡ��� �������','02-992419','��ҹ',810)
INSERT INTO Client  VALUES('��³Ѱ�� �Դ��ԧ','02-9712141','��ҹ',700)
INSERT INTO Client  VALUES('���ʹ��ѡ��� �����ͧ','02-362347','�ŵ',360)
INSERT INTO Client  VALUES('����ӹҨ �ͧྪ�','02-6896256','�ŵ',420)
INSERT INTO Client  VALUES('�ҧ��ǹ����ó� �������','02-7398992','��ҹ',950)
INSERT INTO Client  VALUES('�����Ԫҵ� �����','02-5856441','�ŵ',800)
go
select * from Client
--����������㹵��ҧ PROPERTY
INSERT INTO Property  VALUES('19 �.����¸Թ','��ɳ��š','65000','��ҹ',3,700,'12','2')
INSERT INTO Property  VALUES('14 �.�������','��§����','50310','�ŵ',5,700,'2','2')
INSERT INTO Property  VALUES('6 �.����Ǵ��ѧ�Ե','��ا෾�','10200','�ŵ',1,700,'12','5')
INSERT INTO Property  VALUES('2 �.��Ъ��ط��','��ا෾�','10160','�ŵ',3,400,'2','5')
INSERT INTO Property  VALUES('18 �.����','��ا෾�','10400','��ҹ',1,300,'13','4')
INSERT INTO Property  VALUES('5 �.����','��ا෾�','10400','�ŵ',2,200,'10','2')
INSERT INTO Property  VALUES('45  �.����','�شøҹ�','41000','�ŵ',5,800,'8','4')
INSERT INTO Property  VALUES('25 �.����Ǵ��ѧ�Ե','��ا෾�','10200','�ŵ',2,500,'9','4')
INSERT INTO Property  VALUES('50 �. �ͺ���ͧ�͡','��§����','50100','��ҹ',3,500,'11','3')
INSERT INTO Property  VALUES('9  �.��ժ����','�شøҹ�','41000','��ҹ',3,700,'13','4')
INSERT INTO Property  VALUES('3  �.����','�شøҹ�','41000','�ŵ',4,800,'9','4')
INSERT INTO Property  VALUES('6  �.�شô�ɮ�','�شøҹ�','41000','�ŵ',1,1000,'1','2')
INSERT INTO Property  VALUES('50 �.��Ъ��ط��','��ا෾�','10160','��ҹ',3,600,'15','3')
INSERT INTO Property  VALUES('101 �. �ͺ���ͧ�͡','��§����','50100','�ŵ',4,600,'11','4')
INSERT INTO Property  VALUES('78  �.����','�شøҹ�','41000','�ŵ',5,600,'2','1')
INSERT INTO Property  VALUES('8  �.�شô�ɮ�','�شøҹ�','41000','�ŵ',2,900,'8','2')
INSERT INTO Property  VALUES('24  �.��ժ����','�شøҹ�','41000','��ҹ',5,200,'1','4')
INSERT INTO Property  VALUES('100 �.����¸Թ','��ا෾�','10200','�ŵ',5,600,'6','2')
INSERT INTO Property  VALUES('15 �.⪵��','��§����','50000','�ŵ',1,800,'8','4')
INSERT INTO Property  VALUES('104  �.�شô�ɮ�','�شøҹ�','41000','�ŵ',2,900,'12','4')
go
select * from Property
--����������㹵��ҧ VIEWING
INSERT INTO Viewing  VALUES('1','12/03/2010','6','')
INSERT INTO Viewing  VALUES('3','01/04/2010','13','���зҧ���Թ�')
INSERT INTO Viewing  VALUES('5','07/04/2010','4','�������ͧ����')
INSERT INTO Viewing  VALUES('4','19/04/2010','16','���зҧ���Թ�')
INSERT INTO Viewing  VALUES('4','24/04/2010','13','')
INSERT INTO Viewing  VALUES('1','10/06/2010','8','')
INSERT INTO Viewing  VALUES('1','21/06/2010','8','')
INSERT INTO Viewing  VALUES('2','11/08/2010','16','')
INSERT INTO Viewing  VALUES('2','19/08/2010','3','')
INSERT INTO Viewing  VALUES('5','19/08/2010','6','�������ͧ����')
INSERT INTO Viewing  VALUES('2','29/08/2010','13','��鹷�袹Ҵ���')
INSERT INTO Viewing  VALUES('3','06/09/2010','16','')
INSERT INTO Viewing  VALUES('1','30/09/2010','13','')
INSERT INTO Viewing  VALUES('3','06/10/2010','6','���зҧ���Թ�')
INSERT INTO Viewing  VALUES('4','26/10/2010','19','')
INSERT INTO Viewing  VALUES('4','11/11/2010','10','')
INSERT INTO Viewing  VALUES('5','16/11/2010','1','')
INSERT INTO Viewing  VALUES('1','17/11/2010','9','��鹷�袹Ҵ���')
INSERT INTO Viewing  VALUES('4','20/11/2010','20','')
INSERT INTO Viewing  VALUES('2','03/12/2010','9','')
INSERT INTO Viewing  VALUES('17','06/12/2010','20','')
INSERT INTO Viewing  VALUES('8','23/12/2010','2','�������ͧ����')
INSERT INTO Viewing  VALUES('18','25/01/2011','15','')
INSERT INTO Viewing  VALUES('13','12/02/2011','10','�������ͧ����')
INSERT INTO Viewing  VALUES('17','01/03/2011','7','���зҧ���Թ�')
INSERT INTO Viewing  VALUES('3','27/03/2011','12','��鹷�袹Ҵ���')
INSERT INTO Viewing  VALUES('14','11/05/2011','20','')
INSERT INTO Viewing  VALUES('8','01/07/2011','3','��鹷�袹Ҵ���')
INSERT INTO Viewing  VALUES('14','19/07/2011','12','���зҧ���Թ�')
INSERT INTO Viewing  VALUES('17','13/08/2011','18','')
go
select * from Viewing
