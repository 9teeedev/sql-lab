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