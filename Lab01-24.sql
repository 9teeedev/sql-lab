SELECT * FROM Employees
--1. ต้องการรหัสพนักงาน คำนำหน้า ชื่อ นามสกุล ของพนักงานที่อยู่ในเมือง London
SELECT EmployeeID, TitleOfCourtesy, FirstName, LastName FROM Employees WHERE City = 'London'
--2. ต้องการข้อมูลสินค้าที่มีรหัสประเภท 1,2,4,8 และมีราคา ช่วง 50-100$
SELECT * FROM Products WHERE CategoryID IN (1,2,4,8) AND UnitPrice BETWEEN 50 AND 100
--3. ต้องการประเทศ เมือง ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โ?ร ของลูกค้าทั้งหมด
SELECT Country, City, CompanyName, ContactName, Phone FROM Customers
--4. ข้อมูลของสินค้ารหัสประเภท 1 ราคาไม่เกิน 50 หรือสินค้ารหัสประเภทที่ 8 ราคาไม่เกิน 75
SELECT * FROM Products WHERE (CategoryID = 1 AND UnitPrice <=50) OR (CategoryID = 8 AND UnitPrice <= 75)
--5. ชื่อบริษัทลูกค้า ที่อยู่ใน ประเทศ USA ที่ไม่มีหมายเลข FAX เรียงลำดับชื่อบริษัท
SELECT CompanyName FROM Customers WHERE Country = 'USA' AND FAX IS NULL ORDER BY CompanyName ASC
--6. ต้องการรหัสลูกค้า ชื่อบริษัท และ ชื่อผู้ติดต่อ เฉพาะ ชื่อบริษัทที่มีคำว่า 'con'
SELECT CustomerID, CompanyName, ContactName FROM Customers WHERE CompanyName LIKE '%con%'

SELECT ProductID as รหัสสินค้า, ProductName as ชื่อสินค้า, UnitPrice as ราคา, UnitsInStock as จำนวน, UnitPrice * UnitsInStock AS มูลค่าสินค้า FROM Products --Alias name
SELECT * FROM Products

SELECT ProductID as รหัส, ProductName as สินค้า, UnitsInstock + UnitsOnOrder as จำนวนคงเหลือทั้งหมด, ReorderLevel as จุดสั่งซื้อ FROM Products WHERE (UnitsInStock + UnitsOnOrder) < ReorderLevel

SELECT ProductID, ProductName, UnitPrice, ROUND(UnitPrice * 0.07, 2) AS VAT7 FROM Products

SELECT EmployeeID, TitleOfCourtesy, FirstName+space(1)+lastname as [Employee Name] FROM Employees

-- ต้องการคำนวณรายการสินค้าในรายการขายที่ 10248 ใช้ตาราง {Order Detail}
SELECT orderID, ProductID, UnitPrice, Quantity, Discount, ROUND((UnitPrice*Quantity)*(1-Discount),2) as NetPrice FROM [Order Details] WHERE orderID = 10250