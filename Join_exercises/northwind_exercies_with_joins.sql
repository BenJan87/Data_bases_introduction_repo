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

-- 3.

SELECT COUNT(E.EmployeeID) AS EmployeeCount, 
    COUNT(C.CustomerID) AS CustomerCount,
    C.City
FROM Employees AS E
RIGHT JOIN Customers AS C
ON E.City = C.City
GROUP BY C.City
ORDER BY C.City


-- 4.

SELECT COALESCE(E.city, C.city) AS City, COUNT(E.EmployeeID) AS EmployeeCount,
    COUNT(C.CustomerID) AS CustomerCount
FROM Employees AS E
FULL JOIN Customers AS C
ON E.City = C.City
GROUP BY COALESCE(E.City, C.city)
ORDER BY COALESCE(E.City, C.city)