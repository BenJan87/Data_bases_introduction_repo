-- for each cutomer check the number 
-- of products which were ordered 

SELECT C.CustomerID, C.CompanyName, 
    sum(OD.Quantity) AS ProductCount
FROM Customers AS C
LEFT JOIN Orders AS O 
ON O.CustomerID = C.CustomerID
JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
GROUP BY C.CustomerID, C.CompanyName



--------------------------
-- cw 1

-- For each order give total number of quantity
-- and the company name

--Dla każdego zamówienia podaj łączną liczbę 
-- zamówionych jednostek towaru oraz nazwę klienta

SELECT O.OrderID, C.CustomerID, C.CompanyName, 
    sum(OD.Quantity) AS ProductCount
FROM Customers AS C
LEFT JOIN Orders AS O 
ON O.CustomerID = C.CustomerID
JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
GROUP BY O.OrderID, C.CustomerID, C.CompanyName


-- Modify the previous query to show orders
-- that contains more than 250 products per order

-- Zmodyfikuj poprzedni przykład, aby pokazać tylko 
-- takie zamówienia, dla których łączna 
-- liczbę zamówionych jednostek jest większa niż 250

SELECT O.OrderID, C.CustomerID, C.CompanyName,
    sum(OD.Quantity) AS ProductCount
FROM Customers AS C
LEFT JOIN Orders AS O 
ON O.CustomerID = C.CustomerID
JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
GROUP BY O.OrderID, C.CustomerID, C.CompanyName
HAVING sum(OD.Quantity) > 250



-- For each order give the total value of that order
-- and the name of the customer

-- Dla każdego zamówienia podaj łączną wartość tego 
-- zamówienia oraz nazwę klienta.

SELECT O.OrderID, C.CustomerID, C.CompanyName, 
    sum(OD.Quantity*OD.UnitPrice*(1-Discount)) AS TotalValue
FROM Customers AS C
LEFT JOIN Orders AS O 
ON O.CustomerID = C.CustomerID
JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
GROUP BY O.OrderID, C.CustomerID, C.CompanyName


-- Modify the previous query in such a way
-- that the total quantity of the product is
-- greater than 250

-- Zmodyfikuj poprzedni przykład, aby pokazać 
-- tylko takie zamówienia, dla których
-- łączna liczba jednostek jest większa niż 250.

SELECT O.OrderID, C.CustomerID, C.CompanyName, 
    sum(OD.Quantity*OD.UnitPrice*(1-Discount)) AS TotalValue
FROM Customers AS C
LEFT JOIN Orders AS O 
ON O.CustomerID = C.CustomerID
JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
GROUP BY O.OrderID, C.CustomerID, C.CompanyName
HAVING sum(OD.Quantity) > 250


-- Once again, modify the previous query
-- in such a way that it also shows the name
-- the surname of the employee which took
-- the order

-- Zmodyfikuj poprzedni przykład tak żeby 
-- dodać jeszcze imię i nazwisko
-- pracownika obsługującego zamówienie

SELECT O.OrderID, C.CustomerID, C.CompanyName, 
    sum(OD.Quantity*OD.UnitPrice*(1-Discount)) AS TotalValue, 
    E.FirstName, E.LastName
FROM Customers AS C
LEFT JOIN Orders AS O 
ON O.CustomerID = C.CustomerID
JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
JOIN Employees AS E
ON E.EmployeeID = O.EmployeeID
GROUP BY O.OrderID, C.CustomerID, C.CompanyName, 
    E.FirstName, E.LastName
HAVING sum(OD.Quantity) > 250



-----------------------------------------
-- cw 2

-- For each category of the product give
-- the total number of quantity ordered by
-- clients from this category

-- Dla każdej kategorii produktu (nazwa), 
-- podaj łączną liczbę zamówionych przez
-- klientów jednostek towarów z tek kategorii.

SELECT C.CategoryID, C.CategoryName, 
    SUM(OD.Quantity) AS TotalQuantity 
FROM Categories AS C 
LEFT JOIN Products AS P
ON C.CategoryID = P.CategoryID
JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
GROUP BY C.CategoryID, C.CategoryName


-- For each of the category, give the total value
-- of the ordered products by clients from this category

-- Dla każdej kategorii produktu (nazwa), 
-- podaj łączną wartość zamówionych przez
-- klientów jednostek towarów z tek kategorii.

SELECT C.CategoryID, C.CategoryName, 
    SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) AS TotalValue
FROM Categories AS C 
LEFT JOIN Products AS P
ON C.CategoryID = P.CategoryID
JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
GROUP BY C.CategoryID, C.CategoryName

-- Sort these result in the previous query by:
-- a) Total value
-- b) Total quantity

-- Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
-- a) łącznej wartości zamówień
-- b) łącznej liczby zamówionych przez klientów jednostek towarów.

SELECT C.CategoryID, C.CategoryName, 
    SUM(OD.Quantity) AS TotalQuantity ,
    SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) AS TotalValue
FROM Categories AS C 
LEFT JOIN Products AS P
ON C.CategoryID = P.CategoryID
JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
GROUP BY C.CategoryID, C.CategoryName
ORDER BY TotalValue, TotalQuantity 


-- For each order, give its value,
-- but also include the freight

-- Dla każdego zamówienia podaj jego 
-- wartość uwzględniając opłatę za przesyłkę

SELECT O.OrderID, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) + O.Freight AS TotalValue
FROM Orders AS O
JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
GROUP BY O.OrderID, O.Freight



---------------------------------------------------
-- cw 3

-- For each shipper, give the total number 
-- of shipped orders in 1997

-- Dla każdego przewoźnika (nazwa) podaj 
-- liczbę zamówień które przewieźli w 1997r

SELECT SH.ShipperID, COUNT(OrderID) AS TotalOrders 
FROM Shippers AS SH
LEFT JOIN Orders AS O
ON SH.ShipperID = O.ShipVia AND YEAR(O.ShippedDate) = 1997
GROUP BY SH.ShipperID


-- Which shipper did the most orders ship?
-- Give the name of this shipper

-- Który z przewoźników był najaktywniejszy 
-- (przewiózł największą liczbę zamówień) w 1997r, 
-- podaj nazwę tego przewoźnika

SELECT TOP 1 SH.ShipperID, SH.CompanyName, COUNT(O.OrderID) AS TotalOrders 
FROM Shippers AS SH 
LEFT JOIN Orders AS O
ON SH.ShipperID = O.ShipVia AND YEAR(O.ShippedDate) = 1997
GROUP BY SH.ShipperID, SH.CompanyName
ORDER BY TotalOrders DESC


-- For each employee (first name and last name)
-- give the total value of orders
-- which were fulfilled by this employee

-- Dla każdego pracownika (imię i nazwisko) 
-- podaj łączną wartość zamówień
-- obsłużonych przez tego pracownika

SELECT E.EmployeeID, E.FirstName, E.LastName, SUM(OD.UnitPrice*OD.Quantity*(1 - OD.Discount)) AS TotalValue
FROM Employees AS E
LEFT JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID, E.FirstName, E.LastName 


-- Which employee did handle the greatest 
-- number of orders in 1997 - give first
-- name and last name

-- Który z pracowników obsłużył największą 
-- liczbę zamówień w 1997r, podaj imię i
-- nazwisko takiego pracownika

SELECT TOP 1 E.EmployeeID, E.FirstName, E.LastName, COUNT(O.OrderID) AS TotalOrders
FROM Employees AS E
LEFT JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID AND YEAR(ShippedDate) = 1997 
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY TotalOrders DESC


-- which one of the employees was the most active
-- (handled the greatest value of orders) in 1997,
-- give first name and last name of this coworker

-- Który z pracowników obsłużył najaktywniejszy 
-- (obsłużył zamówienia o największej wartości) w 1997r, 
-- podaj imię i nazwisko takiego pracownika

SELECT TOP 1 E.EmployeeID, E.FirstName, E.LastName, SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) AS TotalValue
FROM Employees AS E
LEFT JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID AND YEAR(ShippedDate) = 1997 
JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY TotalValue DESC


-- For each employee (first name and last name)
-- give the total value of the orders which were handled
-- by the employee and: limit the result only to:
--      a) workers who have subordinate/s
--      b) workers who don't have any

-- Dla każdego pracownika (imię i nazwisko) 
-- podaj łączną wartość zamówień
-- obsłużonych przez tego pracownika
-- Ogranicz wynik tylko do pracowników
--      a) którzy mają podwładnych
--      b) którzy nie mają podwładnych

-- a)
SELECT E.EmployeeID, E.FirstName, E.LastName, SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) AS TotalValue
FROM Employees AS E
JOIN (
    SELECT DISTINCT ReportsTo
    FROM Employees
) AS K ON E.EmployeeID = K.ReportsTo
LEFT JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID, E.FirstName, E.LastName

-- sec solution for a)
SELECT E.EmployeeID, E.FirstName, E.LastName, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalValue
FROM Employees AS E
JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
WHERE E.EmployeeID IN (SELECT DISTINCT ReportsTo FROM Employees)
GROUP BY E.EmployeeID, E.FirstName, E.LastName


-- b)
SELECT E.EmployeeID, E.FirstName, E.LastName, SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)) AS TotalValue
FROM Employees AS E
LEFT JOIN (
    SELECT DISTINCT ReportsTo 
    FROM Employees
) AS K ON E.EmployeeID = K.ReportsTo
JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] AS OD
ON O.OrderID = OD.OrderID
WHERE K.ReportsTo IS NULL
GROUP BY E.EmployeeID, E.FirstName, E.LastName