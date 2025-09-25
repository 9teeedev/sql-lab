-- สร้างสคริปต์ SQL สำหรับสร้างฐานข้อมูล ZooDB และตารางต่างๆ ของ SQL Server
Use master
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'ZooDB')
BEGIN
    CREATE DATABASE ZooDB;
END
GO

USE ZooDB;
GO
CREATE TABLE AnimalType (
    animal_type_id int primary key NOT NULL,
    type_name NVARCHAR(100) NOT NULL,
    description  NVARCHAR(MAX)
);

CREATE TABLE SpeciesInfo (
    species_info_id int PRIMARY KEY NOT NULL,
    common_name NVARCHAR(100),
    scientific_name NVARCHAR(100),
    habitat NVARCHAR(MAX),
    diet NVARCHAR(MAX),
    conversation_status NVARCHAR(100),
    description NVARCHAR(MAX)
)

CREATE TABLE Enclosure(
    enclosure_id int PRIMARY KEY NOT NULL,
    name NVARCHAR(100) NOT NULL,
    location NVARCHAR(200)
)

CREATE TABLE Keeper (
    keeper_id int PRIMARY KEY NOT NULL,
    name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(50),
    email NVARCHAR(100)
)

CREATE TABLE EnclosureKeeper (
    enclosure_id int NOT NULL,
    keeper_id int NOT NULL,
    PRIMARY KEY (enclosure_id, keeper_id),
    FOREIGN KEY (enclosure_id) REFERENCES Enclosure(enclosure_id),
    FOREIGN KEY (keeper_id) REFERENCES Keeper(keeper_id)
)

CREATE TABLE Food (
    food_id int PRIMARY KEY NOT NULL,
    name NVARCHAR(100) NOT NULL,
    type NVARCHAR(100),
    unit NVARCHAR(50)
)

CREATE TABLE Animal (
    animal_id int PRIMARY KEY NOT NULL,
    name NVARCHAR(100) NOT NULL,
    gender NVARCHAR(10),
    birth_date DATE,
    enclosure_id int,
    animal_type_id int,
    species_info_id int,
    FOREIGN KEY (enclosure_id) REFERENCES Enclosure(enclosure_id),
    FOREIGN KEY (animal_type_id) REFERENCES AnimalType(animal_type_id),
    FOREIGN KEY (species_info_id) REFERENCES SpeciesInfo(species_info_id)
)

CREATE TABLE FeedingSchedule (
    feeding_id int PRIMARY KEY NOT NULL,
    animal_id int NOT NULL,
    food_id int NOT NULL,
    amount DECIMAL(10,2),
    feeding_date DATE,
    feeding_time TIME,
    keeper_id int,
    FOREIGN KEY (keeper_id) REFERENCES Keeper(keeper_id),
    FOREIGN KEY (animal_id) REFERENCES Animal(animal_id),
    FOREIGN KEY (food_id) REFERENCES Food(food_id)
)
