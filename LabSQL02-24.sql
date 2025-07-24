SELECT ProductID as รหัสสินค้า, ProductName as ชื่อสินค้า, UnitPrice as ราคา, UnitsInStock as จำนวน, UnitPrice * UnitsInStock AS มูลค่าสินค้า FROM Products --Alias name
SELECT * FROM Products

SELECT ProductID as รหัส, ProductName as สินค้า, UnitsInstock + UnitsOnOrder as จำนวนคงเหลือทั้งหมด, ReorderLevel as จุดสั่งซื้อ FROM Products WHERE (UnitsInStock + UnitsOnOrder) < ReorderLevel

SELECT ProductID, ProductName, UnitPrice, ROUND(UnitPrice * 0.07, 2) AS VAT7 FROM Products

SELECT EmployeeID, TitleOfCourtesy, FirstName+space(1)+lastname as [Employee Name] FROM Employees

-- ต้องการคำนวณรายการสินค้าในรายการขายที่ 10248 ใช้ตาราง {Order Detail}
SELECT orderID, ProductID, UnitPrice, Quantity, Discount, ROUND((UnitPrice*Quantity)*(1-Discount),2) as NetPrice FROM [Order Details] WHERE orderID = 10250

SELECT COUNT(*) AS จำนวน FROM Products WHERE UnitsInStock < 15

--ต้องการทราบจำนวนพนักงาน
SELECT COUNT(*) AS พนักงานทั้งหมด FROM Employees
-- ต้องการทราบจำนวนลูกค้าที่อยู่ในประเทศบราซิล
SELECT COUNT(*) AS จำนวนลูกค้า FROM Customers WHERE Country = 'Brazil'
-- ต้องการทราบจำนวนรายการสินค้าในใบสั่งซือ้หมายเลข 10250
SELECT COUNT(*) AS รายการสินค้า FROM [Order Details] WHERE OrderID = '10250'
-- ต้องการทราบจำนวนใบสั่งซื้อที่ถูกส่งไปประเทศ Japan
SELECT COUNT(*) AS จำนวนใบสั่งซื้อ FROM Orders WHERE ShipCountry = 'Japan'

-- ต้องการราคาสินค้าต่ำสุด สูงสุด ค่าเฉลี่ย 
SELECT MIN(UnitPrice) as ราคาต่ำสุด, MAX(UnitPrice) as ราคาสูงสุด, AVG(UnitPrice) as เฉลี่ย FROM Products

-- ต้องการเฉลี่ย ราคาสูงสุด ต่ำสุด ของรหัสสินค้า 5 ที่ขายได้
SELECT AVG(UnitPrice) as ราคาเฉลี่ย, MAX(UnitPrice) as ราคาสูงสุด, MIN(UnitPrice) as ราคาต่ำสุด FROM [Order Details] WHERE ProductID = '5' 

SELECT Country, COUNT(*) as [Number of Country] FROM Customers GROUP BY Country ORDER BY [Number of Country] desc

-- ชื่อประเทศ เมือง และจำนวนลูกค้าในแต่ละเมือง
SELECT Country, City, COUNT(*) as [Number of Country] FROM Customers GROUP BY Country, City ORDER BY [Number of Country] desc

-- ต้องการข้อมูลจำนวนใบสั่งซื้อที่ส่งไปในแต่ละประเทศ -- orders
SELECT ShipCountry,COUNT(*) as [จำนวนใบสั่งซื้อ] FROM Orders GROUP BY ShipCountry HAVING count(*) > 100

SELECT Country, city, COUNT(*) as [Num of Country] FROM Customers GROUP BY Country, City HAVING count(*) > 1

-- ต้องการจำนวนใบสั่งซื้อที่สง่ไปในแต่ละประเทศ เฉพาะในปี 1997 และมีจำนวนน้อยกว่า 5 รายการ
SELECT ShipCountry, COUNT(*) as [จำนวนใบสั่งซื้อ] FROM Orders WHERE YEAR(OrderDate) = 1997 GROUP BY ShipCountry HAVING Count(*) < 5
SELECT * FROM [Order Details]
-- ต้องการรหัสสินค้า และ จำนวนที่ขายได้ทั้งหมด 
SELECT ProductID, SUM(Quantity) AS จำนวนที่ขายได้, MAX(UnitPrice) ราคาสูงสุด, MIN(UnitPrice) ราคาต่ำสุด, AVG(UnitPrice) เฉลี่ย FROM [Order Details] GROUP BY ProductID ORDER BY ProductID