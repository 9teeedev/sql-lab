
--เปลี่ยนไปใช้ system Database Master
USE master
GO
--ตรวจสอบว่ามีชื่อซ้ำกันหรือไม่ ถ้ามีให้ลบออก
if exists (select * from sysdatabases where name = 'DreamHome')
	drop database DreamHome
go
--สร้าง Database ชื่อ DreamHome
create database DreamHome

--เซ็ตโค้ดภาษาไทย
Alter Database DreamHome Collate Thai_CI_AS
go

SET DATEFORMAT dmy
GO
--เปลี่ยนไปใช้ DreamHome
use DreamHome
go
--สร้างตารางข้อมูล
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
--เพิ่มข้อมูลในตาราง BRANCH
INSERT INTO Branch  VALUES('B005','21 ถ.ห้วยแก้ว','เชียงใหม่','50300')
INSERT INTO Branch  VALUES('B007','56 ถ.พหลโยธิน','พิษณุโลก','65150')
INSERT INTO Branch  VALUES('B003','143 ถ.วิภาวดีรังสิต','กรุงเทพฯ','10110')
INSERT INTO Branch  VALUES('B004','22 ถ.สหมิตร','เชียงราย','57000')
INSERT INTO Branch  VALUES('B002','11 ถ.พหลโยธิน','เชียงใหม่','50300')
go
select * from BRANCH
--เพิ่มข้อมูลในตาราง EMPLOYEE
INSERT INTO Employee  VALUES('นายสุเทพ สุดชารี','ผู้จัดการ','M','11/11/1987',30000,'B005')
INSERT INTO Employee  VALUES('นายจตุพล ละคร','ผู้ช่วย','F','15/8/1988',12000,'B003')
INSERT INTO Employee  VALUES('นางสาววิภา วิเชียรเครือ','ซุปเปอร์ไวเซอร์','M','23/7/1985',18000,'B003')
INSERT INTO Employee  VALUES('นายสุทธิลักษณ์ นามแสง','ผู้ช่วย','F','22/7/1985',9000,'B007')
INSERT INTO Employee  VALUES('นายธนพล ชูพุดซา','ผู้จัดการ','F','6/2/1980',24000,'B003')
INSERT INTO Employee  VALUES('นางสาวอรสา นามบุญเรือง','ผู้ช่วย','F','31/8/1987',9000,'B005')
go
select * from Employee
--เพิ่มข้อมูลในตาราง OWNER
INSERT INTO Owner  VALUES('นางสาววารุณี พงษ์นิน','พิษณุโลก','02-149741')
INSERT INTO Owner  VALUES('นายสิทธิชัย บุญมาก','กรุงเทพฯ','02-3916105')
INSERT INTO Owner  VALUES('นางสาวอนันตภรณ์ บุญมี','กรุงเทพฯ','02-2208904')
INSERT INTO Owner  VALUES('นายวัฒนา เพ็ชรสังหาร','กรุงเทพฯ','02-7844718')
INSERT INTO Owner  VALUES('นายกิตติกรณ์ เพชรน้อย','เชียงใหม่','02-8580711')
INSERT INTO Owner  VALUES('นางสาวอมรรัตน์ ชิยางคะบุตร','อุดรธานี','02-6213413')
INSERT INTO Owner  VALUES('นางสาววารีรัตน์ อุทาโย','หนองคาย','02-2139468')
INSERT INTO Owner  VALUES('นางสาวกัญญารัตน์ ชาตา','กรุงเทพฯ','02-9027607')
INSERT INTO Owner  VALUES('นายจิรวัฒน์ แสนสิทธิ์','เชียงใหม่','02-4017713')
INSERT INTO Owner  VALUES('นางสาวกีรติ น้อยมนตรี','อุดรธานี','02-7422635')
INSERT INTO Owner  VALUES('นางสาวลดาวัลย์ เตนาวงศ์','หนองคาย','02-824046')
INSERT INTO Owner  VALUES('นางสาวศิริภา โคตรพิมพ์','อุดรธานี','02-7076622')
INSERT INTO Owner  VALUES('นางสาวสุพัตตรา ปีเลี่ยม','หนองคาย','02-1258381')
INSERT INTO Owner  VALUES('นางสาวกาญจนา ฝ่ายพงษา','กรุงเทพฯ','02-589142')
INSERT INTO Owner  VALUES('นางสาวศิริกุล กันหาชิน','อุดรธานี','02-1250134')
INSERT INTO Owner  VALUES('นางสาวนุจรี ล้วนมงคล','กรุงเทพฯ','02-4955327')
INSERT INTO Owner  VALUES('นางสาวสิเรียม ติใจ','กรุงเทพฯ','02-2967681')
INSERT INTO Owner  VALUES('นายประจักษ์ วงชมภู','หนองคาย','02-9767122')
go
select * from owner
--เพิ่มข้อมูลในตาราง CLIENT
INSERT INTO Client  VALUES('นายพนา คำพิมูล','02-5556677','แฟลต',425)
INSERT INTO Client  VALUES('นายรังสรรค์ สิงหธรรม','02-4433556','แฟลต',350)
INSERT INTO Client  VALUES('นางสาวศิรินันท์ ศิลาเกษ','02-5556699','บ้าน',750)
INSERT INTO Client  VALUES('นายอาทิตย์ สิทธิสิริโกศล','02-3334455','แฟลต',600)
INSERT INTO Client  VALUES('นางสาวอริดา มีจันที','02-5306182','แฟลต',400)
INSERT INTO Client  VALUES('นายจตุรงค์ สีสิงห์','02-6196171','แฟลต',370)
INSERT INTO Client  VALUES('นายทรงวุฒิ บุตรโคตร','02-4963656','บ้าน',310)
INSERT INTO Client  VALUES('นายหัสดี โพธิ์ไพร','02-6226452','แฟลต',360)
INSERT INTO Client  VALUES('นายเฉลิมศักดิ์ ภูเทียมศรี','02-4201947','แฟลต',680)
INSERT INTO Client  VALUES('นายธานินทร์ อุดมศรี','02-7035896','แฟลต',590)
INSERT INTO Client  VALUES('นายประยุทธ ศิลาโคตร','02-755153','บ้าน',670)
INSERT INTO Client  VALUES('นายปวิตร ธรรมรัตน์','02-3511088','แฟลต',360)
INSERT INTO Client  VALUES('นางสาวดารณี ยาวิชัย','02-5051798','บ้าน',870)
INSERT INTO Client  VALUES('นายศรัณย์ ร่วมแก้ว','02-4838751','แฟลต',390)
INSERT INTO Client  VALUES('นายเกียรติศักดิ์ ฉิมพาลี','02-992419','บ้าน',810)
INSERT INTO Client  VALUES('นายณัฐพล ติดเมิง','02-9712141','บ้าน',700)
INSERT INTO Client  VALUES('นายอดิศักดิ์ ไชยเมือง','02-362347','แฟลต',360)
INSERT INTO Client  VALUES('นายอำนาจ กองเพชร','02-6896256','แฟลต',420)
INSERT INTO Client  VALUES('นางสาวนภัสภรณ์ นิลศิริ','02-7398992','บ้าน',950)
INSERT INTO Client  VALUES('นายอภิชาติ พีเกาะ','02-5856441','แฟลต',800)
go
select * from Client
--เพิ่มข้อมูลในตาราง PROPERTY
INSERT INTO Property  VALUES('19 ถ.พหลโยธิน','พิษณุโลก','65000','บ้าน',3,700,'12','2')
INSERT INTO Property  VALUES('14 ถ.ห้วยแก้ว','เชียงใหม่','50310','แฟลต',5,700,'2','2')
INSERT INTO Property  VALUES('6 ถ.วิภาวดีรังสิต','กรุงเทพฯ','10200','แฟลต',1,700,'12','5')
INSERT INTO Property  VALUES('2 ถ.ประชาอุทิศ','กรุงเทพฯ','10160','แฟลต',3,400,'2','5')
INSERT INTO Property  VALUES('18 ถ.พญาไท','กรุงเทพฯ','10400','บ้าน',1,300,'13','4')
INSERT INTO Property  VALUES('5 ถ.พญาไท','กรุงเทพฯ','10400','แฟลต',2,200,'10','2')
INSERT INTO Property  VALUES('45  ถ.ทหาร','อุดรธานี','41000','แฟลต',5,800,'8','4')
INSERT INTO Property  VALUES('25 ถ.วิภาวดีรังสิต','กรุงเทพฯ','10200','แฟลต',2,500,'9','4')
INSERT INTO Property  VALUES('50 ถ. รอบเมืองนอก','เชียงใหม่','50100','บ้าน',3,500,'11','3')
INSERT INTO Property  VALUES('9  ถ.ศรีชมชื่น','อุดรธานี','41000','บ้าน',3,700,'13','4')
INSERT INTO Property  VALUES('3  ถ.ทหาร','อุดรธานี','41000','แฟลต',4,800,'9','4')
INSERT INTO Property  VALUES('6  ถ.อุดรดุษฎี','อุดรธานี','41000','แฟลต',1,1000,'1','2')
INSERT INTO Property  VALUES('50 ถ.ประชาอุทิศ','กรุงเทพฯ','10160','บ้าน',3,600,'15','3')
INSERT INTO Property  VALUES('101 ถ. รอบเมืองนอก','เชียงใหม่','50100','แฟลต',4,600,'11','4')
INSERT INTO Property  VALUES('78  ถ.ทหาร','อุดรธานี','41000','แฟลต',5,600,'2','1')
INSERT INTO Property  VALUES('8  ถ.อุดรดุษฎี','อุดรธานี','41000','แฟลต',2,900,'8','2')
INSERT INTO Property  VALUES('24  ถ.ศรีชมชื่น','อุดรธานี','41000','บ้าน',5,200,'1','4')
INSERT INTO Property  VALUES('100 ถ.พหลโยธิน','กรุงเทพฯ','10200','แฟลต',5,600,'6','2')
INSERT INTO Property  VALUES('15 ถ.โชตนา','เชียงใหม่','50000','แฟลต',1,800,'8','4')
INSERT INTO Property  VALUES('104  ถ.อุดรดุษฎี','อุดรธานี','41000','แฟลต',2,900,'12','4')
go
select * from Property
--เพิ่มข้อมูลในตาราง VIEWING
INSERT INTO Viewing  VALUES('1','12/03/2010','6','')
INSERT INTO Viewing  VALUES('3','01/04/2010','13','ระยะทางไกลเกินไป')
INSERT INTO Viewing  VALUES('5','07/04/2010','4','ไม่มีห้องครัว')
INSERT INTO Viewing  VALUES('4','19/04/2010','16','ระยะทางไกลเกินไป')
INSERT INTO Viewing  VALUES('4','24/04/2010','13','')
INSERT INTO Viewing  VALUES('1','10/06/2010','8','')
INSERT INTO Viewing  VALUES('1','21/06/2010','8','')
INSERT INTO Viewing  VALUES('2','11/08/2010','16','')
INSERT INTO Viewing  VALUES('2','19/08/2010','3','')
INSERT INTO Viewing  VALUES('5','19/08/2010','6','ไม่มีห้องครัว')
INSERT INTO Viewing  VALUES('2','29/08/2010','13','พื้นที่ขนาดเล็ก')
INSERT INTO Viewing  VALUES('3','06/09/2010','16','')
INSERT INTO Viewing  VALUES('1','30/09/2010','13','')
INSERT INTO Viewing  VALUES('3','06/10/2010','6','ระยะทางไกลเกินไป')
INSERT INTO Viewing  VALUES('4','26/10/2010','19','')
INSERT INTO Viewing  VALUES('4','11/11/2010','10','')
INSERT INTO Viewing  VALUES('5','16/11/2010','1','')
INSERT INTO Viewing  VALUES('1','17/11/2010','9','พื้นที่ขนาดเล็ก')
INSERT INTO Viewing  VALUES('4','20/11/2010','20','')
INSERT INTO Viewing  VALUES('2','03/12/2010','9','')
INSERT INTO Viewing  VALUES('17','06/12/2010','20','')
INSERT INTO Viewing  VALUES('8','23/12/2010','2','ไม่มีห้องครัว')
INSERT INTO Viewing  VALUES('18','25/01/2011','15','')
INSERT INTO Viewing  VALUES('13','12/02/2011','10','ไม่มีห้องครัว')
INSERT INTO Viewing  VALUES('17','01/03/2011','7','ระยะทางไกลเกินไป')
INSERT INTO Viewing  VALUES('3','27/03/2011','12','พื้นที่ขนาดเล็ก')
INSERT INTO Viewing  VALUES('14','11/05/2011','20','')
INSERT INTO Viewing  VALUES('8','01/07/2011','3','พื้นที่ขนาดเล็ก')
INSERT INTO Viewing  VALUES('14','19/07/2011','12','ระยะทางไกลเกินไป')
INSERT INTO Viewing  VALUES('17','13/08/2011','18','')
go
select * from Viewing
