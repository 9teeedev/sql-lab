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