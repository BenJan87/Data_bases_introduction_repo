-- sorting by Country and CompanyName
SELECT CompanyName, Country
FROM Customers
WHERE Country IS NOT NULL
ORDER BY Country ASC, CompanyName ASC


-- Sorted by given conditions:
SELECT C.CategoryName, P.ProductName, P.UnitPrice
FROM Products AS P
INNER JOIN 
Categories AS C
ON P.CategoryID = C.CategoryID
ORDER BY C.CategoryName ASC, P.UnitPrice DESC

-- Clients in Japan or Italy:

SELECT CompanyName, Country
FROM Customers
WHERE Country IN ('Japan', 'Italy')
ORDER BY Country ASC, CompanyName ASC


-- Total price for each of the position on OrderId 10250
SELECT ProductID, UnitPrice, Quantity, Discount, 
(UnitPrice * Quantity) * (1 - Discount) AS TotalPrice 
FROM [Order Details]
WHERE OrderID = 10250
ORDER BY TotalPrice DESC


-- One column instead of phone number and fax number
SELECT CompanyName, Phone + ', ' + Fax AS Contact
FROM Suppliers
