--การ Query ข้อมูลจากหลายตาราง (Join)
-- 1.   จงแสดงข้อมูลรหัสใบสั่งซื้อ ชื่อบริษัทลูกค้า ชื่อและนามสกุลพนักงาน(ในคอลัมน์เดียวกัน) วันที่สั่งซื้อ ชื่อบริษัทขนส่งของ เมืองและประเทศที่ส่งของไป รวมถึงยอดเงินที่ต้องรับจากลูกค้าด้วย
-- Orders, Employees, Order Details, Shippers
SELECT O.OrderID, O.ShipName AS Company, E.FirstName+' '+E.LastName AS EmpName, O.OrderDate, S.CompanyName AS Express, O.ShipCity, O.ShipCountry, SUM(OD.Quantity * OD.UnitPrice) AS TotalCash
FROM Orders O 
JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Shippers S ON S.ShipperID = O.ShipVia
GROUP BY O.OrderID, O.ShipName, E.FirstName+' '+E.LastName, O.OrderDate, S.CompanyName, O.ShipCity, O.ShipCountry

-- 2.   จงแสดง ข้อมูล ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เมือง ประเทศ จำนวนใบสั่งซื้อที่เกี่ยวข้องและ ยอดการสั่งซื้อทั้งหมดเลือกมาเฉพาะเดือน มกราคมถึง มีนาคม  1997
-- Customers, Orders, Order Details
SELECT C.CompanyName, C.ContactName, C.City, C.Country, COUNT(O.OrderID) AS COUNT, SUM(OD.Quantity * OD.UnitPrice) AS TotalCash
FROM Customers C 
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE O.OrderDate BETWEEN ('1997-01-01') AND ('1997-03-01')
GROUP BY C.CompanyName, C.ContactName, C.City, C.Country

-- 3.   จงแสดงชื่อเต็มของพนักงาน ตำแหน่ง เบอร์โทรศัพท์ จำนวนใบสั่งซื้อ รวมถึงยอดการสั่งซื้อทั้งหมดในเดือนพฤศจิกายน ธันวาคม 2539  โดยที่ใบสั่งซื้อนั้นถูกส่งไปประเทศ USA, Canada หรือ Mexico
-- Employees, Orders, Order Detail
SELECT E.TitleOfCourtesy, E.FirstName, E.LastName, E.Title, COUNT(O.OrderID) AS COUNT, SUM(OD.Quantity * OD.UnitPrice) AS TotalCash
FROM Employees E 
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE (O.OrderDate BETWEEN ('1996-11-01') AND ('1996-12-01')) AND (O.ShipCountry IN ('USA', 'Canada', 'Mexico'))
GROUP BY E.TitleOfCourtesy, E.FirstName, E.LastName, E.Title

-- 4.   จงแสดงรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย  และจำนวนทั้งหมดที่ขายได้ในเดือน มิถุนายน 2540
-- Products, Order Details, Orders
SELECT P.ProductID, P.ProductName, P.UnitPrice, COUNT(P.ProductID) AS COUNT
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE MONTH(O.OrderDate) = 6
GROUP BY P.ProductID, P.ProductName, P.UnitPrice

-- 5.   จงแสดงรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย และยอดเงินทั้งหมดที่ขายได้ ในเดือน มกราคม 2540 แสดงเป็นทศนิยม 2 ตำแหน่ง
-- Products, Order Details,Orders
SELECT P.ProductID, P.ProductName, ROUND(SUM(OD.Quantity * OD.UnitPrice), 2) AS TotalCash
FROM Products P 
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID
WHERE MONTH(O.OrderDate) = 1 GROUP BY P.ProductID, P.ProductName

-- 6.   จงแสดงชื่อบริษัทตัวแทนจำหน่าย ชื่อผู้ติดต่อ เบอร์โทร เบอร์ Fax รหัส ชื่อสินค้า ราคา จำนวนรวมที่จำหน่ายได้ในปี 1996
-- Products, Customers, Order Details, Orders
SELECT S.CompanyName, C.ContactName, C.Phone, C.Fax, P.ProductID, P.ProductName, COUNT(P.ProductID) AS COUNT
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Suppliers S ON S.SupplierID = P.SupplierID
WHERE YEAR(O.OrderDate) = '1996' GROUP BY S.CompanyName, C.ContactName, C.Phone, C.Fax, P.ProductID, P.ProductName

-- 7.   จงแสดงรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย  และจำนวนทั้งหมดที่ขายได้เฉพาะของสินค้าที่เป็นประเภท Seafood และส่งไปประเทศ USA ในปี 1997
-- Products, Order Details, Orders, Categories
SELECT P.ProductID, P.ProductName, P.UnitPrice, SUM(P.ProductID) AS COUNT
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Categories C ON C.CategoryID = P.CategoryID
WHERE C.CategoryName = 'Seafood' AND O.ShipCountry = 'USA' AND YEAR(O.OrderDate) = '1997'
GROUP BY P.ProductID, P.ProductName, P.UnitPrice

-- 8.   จงแสดงชื่อเต็มของพนักงานที่มีตำแหน่ง Sale Representative อายุงานเป็นปี และจำนวนใบสั่งซื้อทั้งหมดที่รับผิดชอบในปี 1998
-- Employees, Orders
SELECT E.TitleOfCourtesy, E.FirstName, E.LastName, E.Title, (2025-YEAR(E.HireDate)) AS อายุงาน, COUNT(O.OrderID) AS จำนวนคำสั่งซื้อ
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE E.Title = 'Sales Representative' AND YEAR(O.OrderDate) = '1998'
GROUP BY E.TitleOfCourtesy, E.FirstName, E.LastName, E.Title, (2025-YEAR(E.HireDate))

-- 9.   แสดงชื่อเต็มพนักงาน ตำแหน่งงาน ของพนักงานที่ขายสินค้าให้บริษัท Frankenversand ในปี  1996
-- Employees, Orders
SELECT E.TitleOfCourtesy, E.FirstName, E.LastName, E.Title
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE O.ShipName = 'Frankenversand' AND YEAR(O.OrderDate) = '1996'
GROUP BY E.TitleOfCourtesy, E.FirstName, E.LastName, E.Title

-- 10.  จงแสดงชื่อสกุลพนักงานในคอลัมน์เดียวกัน ยอดขายสินค้าประเภท Beverage ที่แต่ละคนขายได้ ในปี 1996
-- Employees, Catgories, Products, Order Details, Orders
SELECT E.FirstName+' '+E.LastName AS empName, SUM(OD.Quantity * OD.UnitPrice) AS TotalCash
FROM Employees E
JOIN Orders O ON O.EmployeeID = E.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Beverages' AND YEAR(O.OrderDate) = '1996' GROUP BY E.FirstName+' '+E.LastName

-- 11.  จงแสดงชื่อประเภทสินค้า รหัสสินค้า ชื่อสินค้า ยอดเงินที่ขายได้(หักส่วนลดด้วย) ในเดือนมกราคม - มีนาคม 2540 โดย มีพนักงานผู้ขายคือ Nancy
-- Categories, Products, Order Details, Order, Employees
SELECT C.CategoryName, P.ProductID, P.ProductName, SUM(OD.Quantity * OD.UnitPrice * (1-OD.Discount)) AS ยอดขาย
FROM Categories C
JOIN Products P ON P.CategoryID = C.CategoryID
JOIN [Order Details] OD ON OD.ProductID = P.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Employees E ON E.EmployeeID = O.EmployeeID
WHERE E.FirstName = 'Nancy' AND YEAR(O.OrderDate) = '1997' AND MONTH(O.OrderDate) BETWEEN '1' AND '4'
GROUP BY C.CategoryName, P.ProductID, P.ProductName

-- 12.  จงแสดงชื่อบริษัทลูกค้าที่ซื้อสินค้าประเภท Seafood ในปี 1997
-- Catgories, Products, Order Details, Orders, Customers
SELECT CM.CompanyName
FROM Categories C
JOIN Products P ON P.CategoryID = C.CategoryID
JOIN [Order Details] OD ON OD.ProductID = P.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers CM ON O.CustomerID = CM.CustomerID
WHERE C.CategoryName = 'Seafood' AND YEAR(O.OrderDate) = '1997'

-- 13.  จงแสดงชื่อบริษัทขนส่งสินค้า ที่ส่งสินค้าให้ ลูกค้าที่มีที่ตั้ง อยู่ที่ถนน Johnstown Road แสดงวันที่ส่งสินค้าด้วย (รูปแบบ 106)
-- Shippers, Orders, Customers
SELECT DISTINCT S.CompanyName, O.ShippedDate
FROM Shippers S
JOIN Orders O ON S.ShipperID = O.ShipVia
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Address LIKE '%Johnstown Road%'

-- 14.  จงแสดงรหัสประเภทสินค้า ชื่อประเภทสินค้า จำนวนสินค้าในประเภทนั้น และยอดรวมที่ขายได้ทั้งหมด แสดงเป็นทศนิยม 4 ตำแหน่ง หักส่วนลด
-- Catgories, Products, Order Details, Orders
SELECT C.CategoryID, C.CategoryName, COUNT(P.ProductID) AS จำนวนสินค้า, ROUND(SUM(OD.Quantity * OD.UnitPrice * (1-OD.Discount)),4) AS ยอดรวม
FROM Categories C
JOIN Products P ON C.CategoryID = P.CategoryID
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY C.CategoryID, C.CategoryName

-- 15.  จงแสดงชื่อบริษัทลูกค้า ที่อยู่ในเมือง London , Cowes ที่สั่งซื้อสินค้าประเภท Seafood จากบริษัทตัวแทนจำหน่ายที่อยู่ในประเทศญี่ปุ่นรวมมูลค่าออกมาเป็นเงินด้วย
-- Customersm Orders, Order Details, Product, Suppliers, Categories
SELECT C.CompanyName, SUM(OD.Quantity*OD.UnitPrice) AS มูลค่า
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Suppliers S ON P.SupplierID = S.SupplierID
JOIN Categories CR ON P.CategoryID = CR.CategoryID
WHERE C.City IN ('London', 'Cowes') AND CR.CategoryName = 'Seafood' AND S.Country = 'Japan' GROUP BY C.CompanyName

-- 16.  แสดงรหัสบริษัทขนส่ง ชื่อบริษัทขนส่ง จำนวนorders ที่ส่ง ค่าขนส่งทั้งหมด  เฉพาะที่ส่งไปประเทศ USA
-- Shippers, Orders, Order Details
SELECT S.ShipperID, S.CompanyName, COUNT(O.OrderID) AS จำนวนorders, SUM(O.Freight) AS ค่าขนส่ง
FROM Shippers S
JOIN Orders O ON S.ShipperID = O.ShipVia
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE O.ShipCountry = 'USA' GROUP BY S.ShipperID, S.CompanyName

-- 17.  จงแสดงเต็มชื่อพนักงาน ที่มีอายุมากกว่า 60ปี จงแสดง ชื่อบริษัทลูกค้า,ชื่อผู้ติดต่อ,เบอร์โทร,Fax,ยอดรวมของสินค้าประเภท Condiment ที่ลูกค้าแต่ละรายซื้อ แสดงเป็นทศนิยม4ตำแหน่ง,และแสดงเฉพาะลูกค้าที่มีเบอร์แฟกซ์
-- Epolyees, Customers, Orders, Order details, Products, Categories
SELECT E.TitleOfCourtesy, E.FirstName, E.LastName, C.CompanyName, C.ContactName, C.Phone, C.Fax, ROUND(SUM(OD.Quantity * OD.UnitPrice), 4) AS ยอดรวม
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories CR ON P.CategoryID = CR.CategoryID
WHERE YEAR(E.BirthDate) > 60 AND C.Fax IS NOT NULL AND CR.CategoryName = 'Condiments'
GROUP BY E.TitleOfCourtesy, E.FirstName, E.LastName, C.CompanyName, C.ContactName, C.Phone, C.Fax

-- 18.  จงแสดงข้อมูลว่า วันที่  3 มิถุนายน 2541 พนักงานแต่ละคน ขายสินค้า ได้เป็นยอดเงินเท่าใด พร้อมทั้งแสดงชื่อคนที่ไม่ได้ขายของด้วย
-- Employees, Orders, Order Detail
SELECT E.FirstName, SUM(OD.Quantity * OD.UnitPrice) AS TotalCash
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE O.OrderDate = '1998-06-03' GROUP BY E.FirstName
-- 19.  จงแสดงรหัสรายการสั่งซื้อ ชื่อพนักงาน ชื่อบริษัทลูกค้า เบอร์โทร วันที่ลูกค้าต้องการสินค้า เฉพาะรายการที่มีพนักงานชื่อมากาเร็ตเป็นคนรับผิดชอบพร้อมทั้งแสดงยอดเงินรวมที่ลูกค้าต้องชำระด้วย (ทศนิยม 2 ตำแหน่ง)
-- Employees, Orders, Customers, Order Details
SELECT O.OrderID, E.FirstName, C.CompanyName, C.Phone, O.RequiredDate, ROUND(SUM(OD.Quantity * OD.UnitPrice),2) AS ยอดรวม
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE E.FirstName = 'Margaret' GROUP BY O.OrderID, E.FirstName, C.CompanyName, C.Phone, O.RequiredDate

-- 20.  จงแสดงชื่อเต็มพนักงาน อายุงานเป็นปี และเป็นเดือน ยอดขายรวมที่ขายได้ เลือกมาเฉพาะลูกค้าที่อยู่ใน USA, Canada, Mexico และอยู่ในไตรมาศแรกของปี 2541
-- Employees, Orders, Order Details
SELECT E.TitleOfCourtesy, E.FirstName, E.LastName, (2025-YEAR(E.HireDate)) AS อายุงานปี, (2025-YEAR(E.HireDate))*12  AS อายุงานเดือน, SUM(OD.Quantity * OD.UnitPrice) AS TotalCash
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE O.ShipCountry IN ('USA', 'Canada', 'Mexico') AND MONTH(O.OrderDate) BETWEEN '1' AND '3'
GROUP BY E.TitleOfCourtesy, E.FirstName, E.LastName, (2025-YEAR(E.HireDate)), (2025-YEAR(E.HireDate))*12