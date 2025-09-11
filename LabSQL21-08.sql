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

SELECT O.OrderID เลขใบสั่งซื้อ, C.CompanyName ลูกค้า, E.FirstName พนักงาน, O.ShipAddress ส่งไปที่
FROM Orders O, Customers C, Employees E WHERE O.CustomerID = C.CustomerID AND O.EmployeeID = E.EmployeeID

-- JOIN OPERATOR
SELECT O.OrderID เลขใบสั่งซื้อ, C.CompanyName ลูกค้า, E.FirstName พนักงาน, O.ShipAddress ส่งไปที่
FROM Orders O 
JOIN Customers C ON O.CustomerID = C.CustomerID  
JOIN Employees E ON O.EmployeeID = E.EmployeeID

-- ต้องการ รหัสพนักงาน ชื่อพนักงาน จำนวนใบสั่งซื้อที่เกี่ยวข้อง ผลรวมของค่าขนส่งในปี 1998
SELECT E.EmployeeID, FirstName, COUNT(*) AS [จำนวน Order],
        SUM(freight) AS [Sum of Freight]
FROM Employees E JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE YEAR(orderdate) = 1998 GROUP BY E.EmployeeID, FirstName 
ORDER BY 3 DESC

-- ต้องการรหัสสินค้า ชื่อสินค้า ที่ nancy ขายได้ ทั้งหมด เรียงตามลำดับรหัสสินค้า
SELECT DISTINCT P.ProductID, P.ProductName FROM 
Employees E JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE E.FirstName = 'Nancy' GROUP BY P.ProductID,P.ProductName

-- ต้องการชื่อบริษัทลูกค้าชื่อ Around the Horn ซื้อสินค้าที่มาจากประเทศอะไรบ้าง
SELECT DISTINCT S.Country FROM 
Customers C JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Suppliers S ON S.SupplierID = P.SupplierID
WHERE C.CompanyName = 'Around the Horn'

-- บริษัทลูกค้าชื่อ Around the Horn ซื้อสินค้าอะไรบ้าง จำนวนเท่าใด
SELECT P.ProductID, P.ProductName, SUM(Quantity) AS [Sum of Quantity] FROM
Customers C JOIN Orders O ON C.CompanyName = O.ShipName
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON P.ProductID = OD.ProductID
WHERE C.CompanyName = 'Around the Horn' GROUP BY P.ProductID, P.ProductName
ORDER BY 1

-- ต้องการหมายเลขใบสั่งซื้อ ชื่อพนักงาน และยอดขายในใบสั่งซื้อนั้น
SELECT O.OrderID, E.FirstName, SUM(od.Quantity * od.UnitPrice * (1-od.Discount)) AS TotalCash FROM 
Orders O JOIN Employees E ON O.EmployeeID = E.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID, E.FirstName ORDER BY OrderID

