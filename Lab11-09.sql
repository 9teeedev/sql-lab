-- 1.   จงแสดงให้เห็นว่าพนักงานแต่ละคนขายสินค้าประเภท Beverage ได้เป็นจำนวนเท่าใด และเป็นจำนวนกี่ชิ้น เฉพาะครึ่งปีแรกของ 2540(ทศนิยม 4 ตำแหน่ง)
SELECT E.EmployeeID, E.FirstName, SUM(OD.Quantity) [จำนวนชิ้น], ROUND(SUM(OD.Quantity * OD.UnitPrice),4) Total  
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Categories C ON C.CategoryID = P.CategoryID
WHERE MONTH(O.OrderDate) BETWEEN '1' AND '6' AND YEAR(O.OrderDate) = '1997' AND C.CategoryName = 'Beverages'
GROUP BY E.EmployeeID, E.FirstName

-- 2.   จงแสดงชื่อบริษัทตัวแทนจำหน่าย  เบอร์โทร เบอร์แฟกซ์ ชื่อผู้ติดต่อ จำนวนชนิดสินค้าประเภท Beverage ที่จำหน่าย โดยแสดงจำนวนสินค้า จากมากไปน้อย 3 อันดับแรก
-- Suppliers, Categories, Products
SELECT TOP 3 S.CompanyName, S.Phone, S.Fax, S.ContactName, COUNT(P.ProductID) AS [จำนวนชนิดสินค้า]
FROM Suppliers S
JOIN Products P ON S.SupplierID = P.SupplierID
JOIN Categories C ON C.CategoryID = P.CategoryID
WHERE C.CategoryName = 'Beverages'
GROUP BY S.CompanyName, S.Phone, S.Fax, S.ContactName
ORDER BY [จำนวนชนิดสินค้า] DESC

-- 3.   จงแสดงข้อมูลชื่อลูกค้า ชื่อผู้ติดต่อ เบอร์โทรศัพท์ ของลูกค้าที่ซื้อของในเดือน สิงหาคม 2539 ยอดรวมของการซื้อโดยแสดงเฉพาะ ลูกค้าที่ไม่มีเบอร์แฟกซ์
SELECT C.CompanyName, C.ContactName, C.Phone, ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดรวมการซื้อ]
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE MONTH(O.OrderDate) = '8' AND YEAR(O.OrderDate) = '1996' AND C.Fax IS NULL
GROUP BY C.CompanyName, C.ContactName, C.Phone

-- 4.   แสดงรหัสสินค้า ชื่อสินค้า จำนวนที่ขายได้ทั้งหมดในปี 2541 ยอดเงินรวมที่ขายได้ทั้งหมดโดยเรียงลำดับตาม จำนวนที่ขายได้เรียงจากน้อยไปมาก พรอ้มทั้งใส่ลำดับที่ ให้กับรายการแต่ละรายการด้วย
SELECT ROW_NUMBER() OVER (ORDER BY SUM(OD.Quantity) ASC) AS [ลำดับ], P.ProductID, P.ProductName, SUM(OD.Quantity) AS [จำนวนที่ขายได้], ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดเงินรวม]
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = '1998'
GROUP BY P.ProductID, P.ProductName
ORDER BY [จำนวนที่ขายได้] ASC

-- 5.   จงแสดงข้อมูลของสินค้าที่ขายในเดือนมกราคม 2540 เรียงตามลำดับจากมากไปน้อย 5 อันดับใส่ลำดับด้วย รวมถึงราคาเฉลี่ยที่ขายให้ลูกค้าทั้งหมดด้วย
SELECT TOP 5 ROW_NUMBER() OVER (ORDER BY SUM(OD.Quantity * OD.UnitPrice) DESC) AS [ลำดับ], P.ProductID, 
P.ProductName, SUM(OD.Quantity) AS [จำนวนที่ขายได้], ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดขายรวม], 
ROUND(AVG(OD.UnitPrice),4) AS [ราคาเฉลี่ย]
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID
WHERE MONTH(O.OrderDate) = '1' AND YEAR(O.OrderDate) = '1997'
GROUP BY P.ProductID, P.ProductName

-- 6.   จงแสดงชื่อพนักงาน จำนวนใบสั่งซื้อ ยอดเงินรวมทั้งหมด ที่พนักงานแต่ละคนขายได้ ในเดือน ธันวาคม 2539 โดยแสดงเพียง 5 อันดับที่มากที่สุด
SELECT TOP 5 E.EmployeeID, E.FirstName, COUNT(O.OrderID) AS [จำนวนใบสั่งซื้อ], ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดเงินรวม]
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE MONTH(O.OrderDate) = '12' AND YEAR(O.OrderDate) = '1996'
GROUP BY E.EmployeeID, E.FirstName
ORDER BY [ยอดเงินรวม] DESC

-- 7.   จงแสดงรหัสสินค้า ชื่อสินค้า ชื่อประเภทสินค้า ที่มียอดขาย สูงสุด 10 อันดับแรก ในเดือน ธันวาคม 2539 โดยแสดงยอดขาย และจำนวนที่ขายด้วย
SELECT TOP 10 P.ProductID, P.ProductName, C.CategoryName, ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดขาย], SUM(OD.Quantity) AS [จำนวนที่ขาย]
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Categories C ON C.CategoryID = P.CategoryID
WHERE MONTH(O.OrderDate) = '12' AND YEAR(O.OrderDate) = '1996'
GROUP BY P.ProductID, P.ProductName, C.CategoryName
ORDER BY [ยอดขาย] DESC

-- 8.   จงแสดงหมายเลขใบสั่งซื้อ ชื่อบริษัทลูกค้า ที่อยู่ เมืองประเทศของลูกค้า ชื่อเต็มพนักงานผู้รับผิดชอบ ยอดรวมในแต่ละใบสั่งซื้อ จำนวนรายการสินค้าในใบสั่งซื้อ และเลือกแสดงเฉพาะที่จำนวนรายการในใบสั่งซื้อมากกว่า 2 รายการ
SELECT O.OrderID, C.CompanyName, C.Address, C.City, C.Country, 
E.FirstName + ' ' + E.LastName AS [ชื่อเต็มพนักงาน],
ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดรวมในใบสั่งซื้อ],
COUNT(OD.ProductID) AS [จำนวนรายการสินค้า]
FROM Orders O
JOIN Customers C ON C.CustomerID = O.CustomerID
JOIN Employees E ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY O.OrderID, C.CompanyName, C.Address, C.City, C.Country, E.FirstName, E.LastName
HAVING COUNT(OD.ProductID) > 2

-- 9.   จงแสดง ชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทร เบอร์แฟกซ์ ยอดที่สั่งซื้อทั้งหมดในเดือน ธันวาคม 2539 แสดงผลเฉพาะลูกค้าที่มีเบอร์แฟกซ์
SELECT C.CompanyName, C.ContactName, C.Phone, C.Fax, ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดที่สั่งซื้อทั้งหมด]
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE MONTH(O.OrderDate) = '12' AND YEAR(O.OrderDate) = '1996' AND C.Fax IS NOT NULL
GROUP BY C.CompanyName, C.ContactName, C.Phone, C.Fax
ORDER BY [ยอดที่สั่งซื้อทั้งหมด] DESC

-- 10.  จงแสดงชื่อเต็มพนักงาน จำนวนใบสั่งซื้อที่รับผิดชอบ ยอดขายรวมทั้งหมด เฉพาะในไตรมาสสุดท้ายของปี 2539 เรียงตามลำดับ มากไปน้อยและแสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
SELECT E.FirstName + ' ' + E.LastName AS [ชื่อเต็มพนักงาน], COUNT(O.OrderID) AS [จำนวนใบสั่งซื้อ], ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดขายรวม]
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE MONTH(O.OrderDate) BETWEEN '10' AND '12' AND YEAR(O.OrderDate) = '1996'
GROUP BY E.FirstName, E.LastName
ORDER BY [ยอดขายรวม] DESC

-- 11.  จงแสดงชื่อพนักงาน และแสดงยอดขายรวมทั้งหมด ของสินค้าที่เป็นประเภท Beverage ที่ส่งไปยังประเทศ ญี่ปุ่น
SELECT E.FirstName, ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดขายรวม]
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Categories C ON C.CategoryID = P.CategoryID
WHERE C.CategoryName = 'Beverages' AND O.ShipCountry = 'Japan'
GROUP BY E.FirstName

-- 12.  แสดงรหัสบริษัทตัวแทนจำหน่าย ชื่อบริษัทตัวแทนจำหน่าย ชื่อผู้ติดต่อ เบอร์โทร ชื่อสินค้าที่ขาย เฉพาะประเภท Seafood ยอดรวมที่ขายได้แต่ละชนิด แสดงผลเป็นทศนิยม 4 ตำแหน่ง เรียงจาก มากไปน้อย 10 อันดับแรก
SELECT TOP 10 S.SupplierID, S.CompanyName, S.ContactName, S.Phone, P.ProductName, ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดรวมที่ขายได้]
FROM Suppliers S
JOIN Products P ON S.SupplierID = P.SupplierID
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Categories C ON C.CategoryID = P.CategoryID
WHERE C.CategoryName = 'Seafood'
GROUP BY S.SupplierID, S.CompanyName, S.ContactName, S.Phone, P.ProductName
ORDER BY [ยอดรวมที่ขายได้] DESC

-- 13.  จงแสดงชื่อเต็มพนักงานทุกคน วันเกิด อายุเป็นปีและเดือน พร้อมด้วยชื่อหัวหน้า
SELECT E.FirstName + ' ' + E.LastName AS [ชื่อเต็มพนักงาน], E.BirthDate, 
2025-YEAR(E.BirthDate) AS [อายุปี], 
ABS(9-MONTH(E.BirthDate)) AS [อายุเดือน]
FROM Employees E

-- 14.  จงแสดงชื่อบริษัทลูกค้าที่อยู่ในประเทศ USA และแสดงยอดเงินการซื้อสินค้าแต่ละประเภทสินค้า
SELECT C.CompanyName, Cat.CategoryName, ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดเงินการซื้อ]
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Categories Cat ON Cat.CategoryID = P.CategoryID
WHERE C.Country = 'USA'
GROUP BY C.CompanyName, Cat.CategoryName

-- 15.  แสดงข้อมูลบริษัทผู้จำหน่าย ชื่อบริษัท ชื่อสินค้าที่บริษัทนั้นจำหน่าย จำนวนสินค้าทั้งหมดที่ขายได้และราคาเฉลี่ยของสินค้าที่ขายไปแต่ละรายการ แสดงผลตัวเลขเป็นทศนิยม 4 ตำแหน่ง
SELECT S.SupplierID, S.CompanyName, P.ProductName, SUM(OD.Quantity) AS [จำนวนที่ขายได้], ROUND(AVG(OD.UnitPrice),4) AS [ราคาเฉลี่ย]
FROM Suppliers S
JOIN Products P ON S.SupplierID = P.SupplierID
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY S.SupplierID, S.CompanyName, P.ProductName
ORDER BY S.CompanyName, P.ProductName

-- 16.  ต้องการชื่อบริษัทผู้ผลิต ชื่อผู้ต่อต่อ เบอร์โทร เบอร์แฟกซ์ เฉพาะผู้ผลิตที่อยู่ประเทศ ญี่ปุ่น พร้อมทั้งชื่อสินค้า และจำนวนที่ขายได้ทั้งหมด หลังจาก 1 มกราคม 2541
SELECT S.CompanyName, S.ContactName, S.Phone, S.Fax, P.ProductName, SUM(OD.Quantity) AS [จำนวนที่ขายได้]
FROM Suppliers S
JOIN Products P ON S.SupplierID = P.SupplierID
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID
WHERE S.Country = 'Japan' AND O.OrderDate > '1998-01-01'
GROUP BY S.CompanyName, S.ContactName, S.Phone, S.Fax, P.ProductName

-- 17.  แสดงชื่อบริษัทขนส่งสินค้า เบอร์โทรศัพท์ จำนวนรายการสั่งซื้อที่ส่งของไปเฉพาะรายการที่ส่งไปให้ลูกค้า ประเทศ USA และ Canada แสดงค่าขนส่งโดยรวมด้วย
SELECT Sh.CompanyName, Sh.Phone, COUNT(O.OrderID) AS [จำนวนรายการสั่งซื้อ], ROUND(SUM(O.Freight),4) AS [ค่าขนส่งรวม]
FROM Shippers Sh
JOIN Orders O ON Sh.ShipperID = O.ShipVia
WHERE O.ShipCountry IN ('USA', 'Canada')
GROUP BY Sh.CompanyName, Sh.Phone

-- 18.  ต้องการข้อมูลรายชื่อบริษัทลูกค้า ชื่อผู้ติดต่อ เบอร์โทรศัพท์ เบอร์แฟกซ์ ของลูกค้าที่ซื้อสินค้าประเภท Seafood แสดงเฉพาะลูกค้าที่มีเบอร์แฟกซ์เท่านั้น
SELECT DISTINCT C.CompanyName, C.ContactName, C.Phone, C.Fax
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Categories Cat ON Cat.CategoryID = P.CategoryID
WHERE Cat.CategoryName = 'Seafood' AND C.Fax IS NOT NULL

-- 19.  จงแสดงชื่อเต็มของพนักงาน  วันเริ่มงาน (รูปแบบ 105) อายุงานเป็นปี เป็นเดือน ยอดขายรวม เฉพาะสินค้าประเภท Condiment ในปี 2540
SELECT E.FirstName + ' ' + E.LastName AS [ชื่อเต็มพนักงาน], 
CONVERT(VARCHAR, E.HireDate, 105) AS [วันเริ่มงาน],
2025-YEAR(E.HireDate) AS [อายุงานปี],
ABS(9-MONTH(E.HireDate)) AS [อายุงานเดือน],
ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดขายรวม]
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Categories C ON C.CategoryID = P.CategoryID
WHERE C.CategoryName = 'Condiments' AND YEAR(O.OrderDate) = '1997'
GROUP BY E.FirstName, E.LastName, E.HireDate

-- 20.  จงแสดงหมายเลขใบสั่งซื้อ  วันที่สั่งซื้อ(รูปแบบ 105) ยอดขายรวมทั้งหมด ในแต่ละใบสั่งซื้อ โดยแสดงเฉพาะ ใบสั่งซื้อที่มียอดจำหน่ายสูงสุด 10 อันดับแรก
SELECT TOP 10 O.OrderID, CONVERT(VARCHAR, O.OrderDate, 105) AS [วันที่สั่งซื้อ], ROUND(SUM(OD.Quantity * OD.UnitPrice),4) AS [ยอดขายรวม]
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID, O.OrderDate
ORDER BY [ยอดขายรวม] DESC