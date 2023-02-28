-- Products within the given price range: < 10 and > 20
SELECT *
FROM Products
WHERE UnitPrice < 10 OR UnitPrice > 20


-- Products within the given price range (inclusive): 20 - 30
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 20 AND 30

-- Clients from Japan and Italy
SELECT CompanyName, Country
FROM Customers
WHERE Country IN ('Japan', 'Italy')

-- Returning columns given below where the task weren't
-- fulfilled and the company comes from Argentina

SELECT OrderID, OrderDate, CustomerID
FROM Orders
WHERE ShippedDate IS NULL AND ShipCountry = 'Argentina'