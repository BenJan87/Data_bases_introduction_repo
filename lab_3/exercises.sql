-- group by - 1
SELECT OrderID, MAX(UnitPrice) AS MaxPrice
FROM [Order Details]
GROUP BY OrderID


-- group by - 2
SELECT OrderID, MAX(UnitPrice) AS MaxPrice
FROM [Order Details]
GROUP BY OrderID
ORDER BY MaxPrice DESC


-- group by - 3
SELECT OrderID, MAX(UnitPrice) AS MaxPrice, MIN(UnitPrice) AS MinPrice
FROM [Order Details]
GROUP BY OrderID


-- group by - 4
SELECT ShipVia, COUNT(OrderID) AS TotalOrders
FROM ORDERS
GROUP BY ShipVia


-- group by - 5
SELECT TOP 1 ShipVia, COUNT(OrderID) AS TotalOrders
FROM ORDERS
WHERE ShippedDate >= '1997-01-01' AND ShippedDate < '1998-01-01'
GROUP BY ShipVia
ORDER BY TotalOrders DESC


-- Having - 1
SELECT OrderID, COUNT(*) AS TotalProducts
FROM [Order Details] 
GROUP BY OrderID
HAVING COUNT(*) > 5


-- Having - 2
SELECT CustomerID, COUNT(OrderID) AS TotalOrders, 
    SUM(Freight) AS TotalFreight
FROM Orders
WHERE YEAR(ShippedDate) = 1998
GROUP BY CustomerID
HAVING COUNT(OrderID) > 8
ORDER BY TotalFreight DESC