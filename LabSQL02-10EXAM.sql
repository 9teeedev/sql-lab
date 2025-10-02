SELECT P.ProductName, P.UnitPrice FROM Products P 
JOIN Categories C ON C.CategoryID = P.CategoryID
JOIN Suppliers S ON S.SupplierID = P.SupplierID
WHERE C.CategoryName = 'Beverages' AND S.CompanyName = 'Bigfoot Breweries'

SELECT COUNT(*) จำนวนใบสั่งซื้อ FROM Orders O
JOIN Customers C ON C.CustomerID = O.CustomerID
WHERE C.CompanyName = 'Around the Horn'

SELECT DISTINCT C.CompanyName FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN Shippers S ON S.ShipperID = O.ShipVia
WHERE O.ShipCountry = 'USA' AND S.CompanyName = 'Federal Shipping'

SELECT P.ProductName, P.UnitPrice FROM Products P 
JOIN Suppliers S ON S.SupplierID = P.SupplierID
WHERE S.CompanyName = 'Norske Meierier'

SELECT E.FirstName, E.LastName, COUNT(*) จำนวนใบสั่งซื้อ FROM Employees E
JOIN Orders O ON O.EmployeeID = E.EmployeeID
GROUP BY E.FirstName, E.LastName

SELECT TOP 1 ProductName, MIN(UnitPrice) ราคาถูกที่สุด FROM Products
GROUP BY ProductName ORDER BY MIN(UnitPrice) ASC