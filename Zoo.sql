--สร้างฐานข้อมูล ชื่อ zoo
create DATABASE Zoo;

--select name from sysdatabases 
    
Drop Database Zoo;

Create table Type (
    TypeID CHAR(3),
    TName varchar(50) not null,
    primary key (TypeID)
)
Drop TABLE Type
select * from Type

Create table animal (
    AID int PRIMARY KEY identity(1,1),
    AName VARCHAR(50),
    Descriptions VARCHAR(255),
    Qty integer DEFAULT 0,
    TypeID CHAR(3),
    FOREIGN KEY (TypeID) REFERENCES Type(TypeID)
)

DROP TABLE Animal

ALTER TABLE Animal
ADD ScienceName Varchar(30) not null