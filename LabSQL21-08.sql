SELECT CategoryName, ProductName, UnitPrice FROM Products, Categories
WHERE Products.CategoryID = Categories.CategoryID
ORDER BY CategoryName

SELECT CategoryName, ProductName, UnitPrice FROM Products JOIN Categories
ON Products.CategoryID = Categories.CategoryID
ORDER BY CategoryName

SELECT CategoryName, ProductName, UnitPrice FROM Products AS P JOIN Categories AS C
ON P.CategoryID = C.CategoryID
ORDER BY CategoryName

SELECT CompanyName, OrderID FROM Orders, Shippers
WHERE Shippers.ShipperID = Orders.ShipVia
ORDER BY OrderID

SELECT CompanyName, OrderID FROM Orders JOIN Shippers
ON Shippers.ShipperID = Orders.ShipVia
ORDER BY OrderID

SELECT P.ProductID, P.ProductName, S.CompanyName, S.Country
FROM Products AS P JOIN Suppliers AS S ON P.SupplierID = S.SupplierID

SELECT P.ProductID, P.ProductName, S.CompanyName, S.Country
FROM Products AS P, Suppliers AS S WHERE P.SupplierID = S.SupplierID


SELECT CompanyName,OrderID FROM Orders, Shippers WHERE Shippers.ShipperID = Orders.ShipVia AND OrderID = 10275

SELECT CompanyName, OrderID FROM Orders JOIN Shippers ON Shippers.ShipperID=Orders.Shipvia WHERE OrderID=10275

-- ต้องการรหัสพนักงาน ชื่อพนักงาน รหัสใบสั่งซื้อที่เกี่ยวข้อง เรียงตามลำดับรหัสพนักงาน
SELECT E.EmployeeID, FirstName+' '+LastName AS Name, OrderID FROM Employees AS E JOIN Orders AS O 
ON E.EmployeeID = O.EmployeeID ORDER BY EmployeeID

-- ต้องการรหัสสินค้า เมือง และประทเศของบริษัทผู้จำหน่าย
SELECT ProductID, ProductName, City, Country FROM Products P JOIN Suppliers S ON P.SupplierID = S.SupplierID

-- ต้องการชื่อบริษัทขนส่ง และจำนวนใบสั่งซื้อที่เกี่ยวข้อง 
SELECT CompanyName, COUNT(*) AS COUNT FROM Orders O JOIN Shippers S ON O.ShipVia = S.ShipperID GROUP BY CompanyName

-- ต้องการรหัสสินค้า ชื่อสินค้า และจำนวนทั้งหมดที่ขาย
SELECT P.ProductID, P.ProductName, SUM(Quantity) FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID GROUP BY P.ProductID, P.ProductName ORDER BY 1