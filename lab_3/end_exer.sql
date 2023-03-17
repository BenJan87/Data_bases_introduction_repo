-- cw1 - 1
SELECT SUM((UnitPrice * Quantity) * (1 - Discount)) AS TotalPrice, OrderID
FROM [Order Details]
GROUP BY OrderID
ORDER BY TotalPrice DESC


-- cw1 - 2
SELECT TOP 10 SUM((UnitPrice * Quantity) * (1 - Discount)) AS TotalPrice, OrderID
FROM [Order Details]
GROUP BY OrderID
ORDER BY TotalPrice DESC


-- cw2 - 1
SELECT ProductID, COUNT(*) AS ProductCount
FROM [Order Details]
WHERE ProductID < 3
GROUP BY ProductID


-- cw2 - 2


SELECT TOP 1 SUM(DATEDIFF(minute, OrderDate, ShippedDate)) AS TimeToWait, CustomerID
FROM ORDERS 
WHERE ShippedDate IS NOT NULL
GROUP BY CustomerID
ORDER BY TimeToWait DESC