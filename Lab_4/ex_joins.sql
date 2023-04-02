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

SELECT C.CustomerID, COUNT(DISTINCT MONTH(O.OrderDate)) AS MonthCount
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID = O.CustomerID AND YEAR(O.OrderDate) = 1997
GROUP BY C.CustomerID


-- Dla każdego klienta podaj liczbę 
-- zamówień w każdym z miesięcy 1997, 98

SELECT C.CustomerID, YEAR(O.OrderDate) AS YearDate, 
    MONTH(O.OrderDate) AS MonthDate, COUNT(MONTH(O.OrderDate)) AS MonthCount
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID AND YEAR(O.OrderDate) IN (1997, 1998)
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate), C.CustomerID
ORDER BY C.CustomerID



-- Wybierz nazwy i numery telefonów klientów , 
-- którym w 1997 roku przesyłki 
-- dostarczała firma ‘United Package’





-- Wybierz nazwy i numery telefonów klientów , 
-- którym w 1997 roku przesyłek nie dostarczała 
-- firma ‘United Package’



-- cw koncowe z join

-- 1. Dla każdego zamówienia podaj łączną liczbę zamówionych jednostek towaru oraz nazwę klienta
select O.OrderID, C.CompanyName, 
    ROUND(sum(Quantity*UnitPrice*(1-Discount)), 2) as SumOfProducts
from [Order Details] as OD
inner join Orders as O on OD.OrderID = O.OrderID
inner join Customers as C on O.CustomerID = C.CustomerID
group by O.OrderID, C.CompanyName;


-- Ćw 2
-- Dla każdej kategorii produktu (nazwa), podaj łączną liczbę zamówionych przez
-- klientów jednostek towarów z tek kategorii.
select CategoryName, sum(Quantity + O.Freight)
from Categories
join Products P on Categories.CategoryID = P.CategoryID
join [Order Details] OD on P.ProductID = OD.ProductID
join Orders O on OD.OrderID = O.OrderID  
group by CategoryName, P.CategoryID

SELECT O.OrderID, 
    OD.UnitPrice * OD.Quantity*(1 - OD.Discount) + O.Freight AS TotalPrice
FROM Orders O
JOIN [Order Details] OD
ON OD.OrderID = O.OrderID


SELECT S.ShipperID, S.CompanyName, count(O.OrderID) AS CountOrder
FROM Shippers AS S
LEFT JOIN Orders AS O
ON S.ShipperID = O.ShipVia AND YEAR(O.ShippedDate) = 1997
GROUP BY S.CompanyName, S.ShipperID 








SELECT C.CustomerID, C.CompanyName, YEAR(O.OrderDate) AS YearDate, 
    MONTH(O.OrderDate) AS MonthDate, COUNT(MONTH(O.OrderDate)) AS MonthCount
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID AND YEAR(O.OrderDate) IN (1997, 1998)
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate), C.CustomerID,  C.CompanyName
ORDER BY C.CustomerID



SELECT C.CustomerID, YEAR(O.OrderDate) AS YearDate, 
    MONTH(O.OrderDate) AS MonthDate, COUNT(MONTH(O.OrderDate)) AS MonthCount
FROM Customers AS C
LEFT JOIN Orders AS O
ON C.CustomerID = O.CustomerID AND YEAR(O.OrderDate) IN (1997, 1998)
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate), C.CustomerID
ORDER BY C.CustomerID


-- Wybierz nazwy i numery telefonów klientów, 
-- którzy kupowali produkty z kategorii ‘Confections’


SELECT DISTINCT C.CustomerID
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Categories Cat ON Cat.CategoryID = P.CategoryID
WHERE Cat.CategoryName = 'Confections' 
 
-- Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produków z kategorii ‘Confections’
SELECT DISTINCT CA.CustomerID 
FROM Customers AS CA
LEFT JOIN (
    SELECT 
    DISTINCT C.CustomerID
    FROM Customers C
    JOIN Orders O ON O.CustomerID = C.CustomerID
    JOIN [Order Details] OD ON OD.OrderID = O.OrderID
    JOIN Products P ON P.ProductID = OD.ProductID
    JOIN Categories Cat ON Cat.CategoryID = P.CategoryID
    WHERE Cat.CategoryName = 'Confections'
) AS CC
ON CA.CustomerID = CC.CustomerID
WHERE CC.CustomerID IS NULL 





