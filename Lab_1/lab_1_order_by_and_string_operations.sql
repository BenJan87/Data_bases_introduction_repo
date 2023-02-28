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


--  
SELECT O.OrderID, O.Freight, D.UnitPrice, D.Quantity, D.Discount
FROM Orders AS O, [Order Details] AS D
WHERE O.OrderID = 10250

-- NOT DONE