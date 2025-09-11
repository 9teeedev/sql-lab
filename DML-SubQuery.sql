-- Sub Query
-- 1. หาตำแหน่งของ Nancy
SELECT * FROM Employees WHERE Firstname = 'Nancy'

-- 2. หาคนอื่นที่ตำแหน่งเดียวกันกับ Nancy
SELECT * FROM Employees WHERE Title = (SELECT Title FROM Employees WHERE FirstName = 'Nancy')

-- 3. ต้องการชื่อพนักงานที่อายุมากที่สุด
SELECT FirstName, LastName FROM Employees WHERE BirthDate = (SELECT min(BirthDate) FROM Employees)
-- 4. ต้องการชื่อสินค้าที่มีราคามากกว่าสินค้าชชื่อ Ikura
SELECT ProductName FROM Products WHERE UnitPrice > (SELECT UnitPrice FROM Products WHERE ProductName = 'Ikura')
-- 5. ต้องการชื่อบริษัทลูกค้าที่อยู่เมืองเดียวกับบริษัทชื่อ Around The Horn
SELECT * FROM Customers
SELECT CompanyName FROM Customers WHERE City = (SELECT City FROM Customers WHERE CompanyName = 'Around The Horn')
-- 6. ต้องการข้อมูลคำสั่งซื้อรายการแรก ในปี 1998
SELECT * FROM Orders WHERE OrderDate = (SELECT min(OrderDate) FROM Orders WHERE YEAR(OrderDate) = '1998')
-- 7. ต้องการชื่อนามสกุลของพนักงานที่เข้างานล่าสุด    
SELECT * FROM Employees WHERE HireDate = (SELECT MAX(HireDate) FROM Employees)
-- 8. ข้อมูลใบสั่งซื้อที่ถูกส่งไปประเทศที่ไม่มีผู้ผลิตสินค้าตั้งอยู่
SELECT * FROM Orders WHERE ShipCountry NOT IN (SELECT DISTINCT Country FROM Suppliers)

-- 9. ต้องการข้อมูลสินค้าที่มีราคาน้อยกกว่า 50
SELECT TOP 10 ROW_NUMBER() OVER (ORDER BY UnitPrice DESC) AS RowNum, ProductID, ProductName, UnitPrice AS RowNum FROM Products WHERE UnitPrice < 50
--* คำสั่ง DML (Insert Update Delete)
--? INSERT
SELECT * FROM Shippers

-- ตารางมี PK เป็น AutoIncremet (AutoNumber)
INSERT INTO Shippers VALUES ('บริษัทตี๋จำกัด', '081-2342342')

INSERT INTO Shippers(CompanyName) VALUES ('บริษัทขนมหาศาลเยอะมาก')

SELECT * FROM Customers
-- ตารางที่ PK เป็น Char, nchar
INSERT INTO Customers (CustomerID, CompanyName, Phone) VALUES ('UDRU1', 'บริษัทซื้อเยอะมาก', '098-3241253')

--? Update
UPDATE Shippers SET Phone = '081-2345678' WHERE CompanyName = 'บริษัทตี๋จำกัด'

UPDATE Shippers SET Phone = '042-12312312' WHERE ShipperID = 5

UPDATE Customers SET ContactName = 'พงษ์ศธร', ContactTitle='HR', Address = 'อุดรธานี Thailand' WHERE CustomerID = 'UDRU1'

--? ปรับปรุงสินค้าคงเหลือ สินค้ารหัส 1 เพิ่มเข้าไป 100 ชิ้น
SELECT * FROM Products
UPDATE Products SET UnitsInStock = UnitsInStock + 100 WHERE ProductID = 1

--? คำสั่ง Delete
SELECT * FROM Shippers
DELETE FROM Shippers WHERE ShipperID = 5
DELETE FROM Shippers WHERE ShipperID = 1 -- ลบไม่ได้เพราะมีตารางอื่นอ้างอิงอยู่