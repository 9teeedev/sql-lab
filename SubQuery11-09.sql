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