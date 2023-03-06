-- Find all orders and their corresponding customers 
SELECT O.OrderID, C.CompanyName
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID

-- List all products 
-- that have been ordered and their corresponding order details.

SELECT P.ProductName, D.OrderID, D.UnitPrice, D.Quantity, D.Discount 
FROM Products AS P
LEFT JOIN [Order Details] AS D
ON P.ProductID = D.ProductID