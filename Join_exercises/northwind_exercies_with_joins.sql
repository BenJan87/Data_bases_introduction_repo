-- https://github.com/eirkostop/SQL-Northwind-exercises
-- The link above contains the exercises,
-- wchich were done below:


-- SQL QUERIES FOR JOINS
-- 1.

SELECT O.OrderDate, O.OrderID, C.CompanyName
FROM Orders AS O
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
WHERE YEAR(OrderDate) = 1996;

-- 2.

SELECT COUNT(E.EmployeeID) AS EmployeeCount, 
    COUNT(C.CustomerID) AS CustomerCount,
    E.City
FROM Employees AS E
LEFT JOIN Customers AS C
ON E.City = C.City
GROUP BY E.City
ORDER BY E.City

-- 3. - not finished
SELECT E.EmployeeID AS EmployeeCount, 
    C.CustomerID AS CustomerCount,
    E.City
FROM Employees AS E
FULL JOIN Customers AS C
ON E.City = C.City





