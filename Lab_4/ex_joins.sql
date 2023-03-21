-- ex. 1
SELECT P.ProductName, P.UnitPrice, S.Address
FROM Products AS P
JOIN Suppliers AS S
ON P.SupplierID = S.SupplierID
WHERE P.UnitPrice BETWEEN 20 AND 30


-- ex. 2
SELECT P.ProductName, P.UnitsInStock
FROM Products AS P
JOIN Suppliers AS S
ON P.SupplierID = S.SupplierID
WHERE S.CompanyName = 'Tokyo Traders'

-- SELECT COUNT(O.OrderID) AS CountOrders, C.CustomerID, C.Address, YEAR(O.OrderDate) As Year
-- FROM Orders AS O
-- RIGHT JOIN Customers AS C
-- ON O.CustomerID = C.CustomerID
-- GROUP BY YEAR(O.OrderDate), C.CustomerID, C.Address
-- HAVING YEAR(O.OrderDate) = 1997 AND COUNT(O.OrderID) = 0


-- ex. 3 - first solution
SELECT C.CustomerID, C.CompanyName, C.City, C.Address
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID AND YEAR(O.OrderDate) = 1997
WHERE O.OrderID IS NULL


-- ex. 3 - solution with group by
SELECT C.CustomerID, C.CompanyName, C.City, COUNT(O.OrderID)
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID AND YEAR(O.OrderDate) = 1997
GROUP BY C.CustomerID, C.CompanyName, C.City
HAVING COUNT(O.OrderID) = 0


-- ex.3 - solution with two selects
SELECT CustomerID, CompanyName, Address
FROM Customers AS C
WHERE C.CustomerID NOT IN (
    SELECT CustomerID
    FROM Orders                           
    WHERE year(OrderDate) = 1997
    )



-- dla każdego kliena podaj w ilu różnych miesiącach 
-- (latach i miesiącah) robił zakupy w 1997r

-- Dla każdego klienta podaj liczbę 
-- zamówień w każdym z miesięcy 1997, 98

-- Wybierz nazwy i numery telefonów klientów , 
-- którym w 1997 roku przesyłki 
-- dostarczała firma ‘United Package’

-- Wybierz nazwy i numery telefonów klientów , 
-- którym w 1997 roku przesyłek nie dostarczała 
-- firma ‘United Package’