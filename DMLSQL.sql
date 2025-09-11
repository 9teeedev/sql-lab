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