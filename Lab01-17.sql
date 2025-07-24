SELECT * FROM Employees -- เลือกข้อมูลทั้งหมดจากตาราง Employees
SELECT EmployeeID, FirstName, LastName FROM Employees -- เลือกเฉพาะคอลัมน์ EmployeeID, FirstName, LastName จากตาราง Employees
SELECT * 
FROM Employees
WHERE City = 'London' -- เลือกข้อมูลจากตาราง Employees ที่อยู่ในเมือง London

SELECT City, Country FROM Customers -- เลือกคอลัมน์ City และ Country จากตาราง Customers
SELECT DISTINCT City, Country FROM Customers -- เลือกคอลัมน์ City และ Country จากตาราง Customers โดยไม่ซ้ำกัน

SELECT * FROM Products WHERE UnitPrice <= 5 -- เลือกข้อมูลจากตาราง Products ที่ราคาต่อหน่วยไม่เกิน 5

SELECT * FROM Customers WHERE City = 'London' OR City = 'Vancouver'

SELECT * FROM Customers WHERE Country = 'USA' OR City = 'Vancouver'

SELECT CompanyName, ContactName, Phone FROM Customers WHERE Country = 'USA' OR City = 'Vancouver'

SELECT * FROM Products WHERE UnitPrice >= 50 OR UnitsInStock < 20

SELECT * FROM Products WHERE UnitPrice BETWEEN 50 AND 100

SELECT * FROM Products WHERE UnitPrice >= 0 AND UnitPrice <= 10

SELECT * FROM Customers WHERE NOT (Country IN ('Brazil', 'Argentina', 'Mexico'))
SELECT * FROM Customers WHERE Country = 'Brazil' OR Country = 'Argentina' OR Country = 'Mexico'

SELECT * FROM Customers WHERE Fax IS NULL

SELECT * FROM Customers WHERE Fax IS NOT NULL

SELECT * FROM Customers WHERE NOT (Fax IS NULL) 

SELECT * FROM Customers WHERE Country LIKE '%land' -- เลือกข้อมูลจาก Customers ที่ Country ลงท้ายด้วย 'land'

-- ต้องการข้อมูลลูกค้าที่ชื่อบริษัทมีคำว่า 'Chi' อยู่ในนั้น
SELECT * FROM Customers WHERE CompanyName LIKE '%Chi%'

-- ต้องการข้อมูลลูกค้าที่ชื่อบริษัท หรือชื่อผู้ติดต่อ มีตัวอักษร ny
SELECT * FROM Customers WHERE CompanyName LIKE '%ny%' OR ContactName LIKE '%ny%'


SELECT * FROM Employees WHERE FirstName Like '_____' -- เลือกข้อมูลจาก Employees ที่ FirstName มีความยาว 5 ตัวอักษร

-- ต้องการข้อมู,พนักงานที่มีอักษรในชื่อตัวที่ 2 เป็น 'a'
SELECT * FROM Employees WHERE FirstName LIKE '_a%'

-- ต้องการข้อมูลพนักงานที่มีอักษรนำขึ้นต้นด้วย a r s
SELECT * FROM Employees WHERE FirstName LIKE '[ars]%' -- เลือกข้อมูลพนักงานที่ FirstName เริ่มต้นด้วย a, r หรือ s

-- ต้องการข้อมูลพนักงานที่มีอักษรนำขึ้นต้นด้วย a-m
SELECT * FROM Employees WHERE FirstName LIKE '[a-m]%'

-- เรียกตัวแทนที่ใช้แทนตัวอักษรทั้งหลายว่า Wildcard ประกอบด้วย % _ [] - 

SELECT ProductID, ProductName, UnitPrice FROM Products ORDER BY UnitPrice DESC -- เรียงลำดับข้อมูลจากตาราง Products ตาม UnitPrice จากมากไปน้อย
SELECT ProductID, ProductName, UnitPrice FROM Products ORDER BY UnitPrice ASC -- เรียงลำดับข้อมูลจากตาราง Products ตาม UnitPrice จากน้อยไปมาก

SELECT CompanyName, ContactName FROM Customers ORDER BY ContactName ASC

SELECT CategoryID, ProductName, UnitPrice FROM Products ORDER BY CategoryID ASC, UnitPrice DESC -- เรียงลำดับข้อมูลจาก Products ตาม CategoryID และ UnitPrice จากมากไปน้อย