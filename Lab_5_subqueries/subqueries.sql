-- cw1
-- select the names and phone numbers of the clients, whom were delivered the packeges by United Package
-- Wybierz nazwy i numery telefonów klientów, którym w 1997 roku przesyłki dostarczała firma United Package.

SELECT P.ProductID, P.ProductName ,(
    SELECT MAX(Quantity) AS MaxQuantity
    FROM [Order Details] AS OD
    WHERE P.ProductID = OD.ProductID
) AS MaxValue
FROM Products AS P


-- cw 2.
-- Dla każdego produktu podaj maksymalną
-- liczbę zamówionych jednostek

-- For each product give the maximum number
-- of quantity wchich were ordered


SELECT DISTINCT productid, quantity
FROM [order details] AS ord1
WHERE quantity = ( SELECT MAX(quantity)
FROM [order details] AS ord2
WHERE ord1.productid =
ord2.productid )

-- Podaj wszystkie produkty, których cena jest 
-- mniejsza niż średnia cena wszystkich produktów

-- 

SELECT ProductID, UnitPrice
FROM Products
WHERE UnitPrice < (
    SELECT AVG(UnitPrice)
    FROM Products
)

-- Podaj wszystkie produkty, których 
-- cena jest mniejsza niż średnia cena produktów danej kategorii


WITH CatAvg AS (
    SELECT C.CategoryID, AVG(P.UnitPrice) AS AvgPerCategory
    FROM Categories AS C
    JOIN Products AS P
    ON P.CategoryID = C.CategoryID
    GROUP BY C.CategoryID
)
SELECT P.ProductID, P.UnitPrice, CA.CategoryID, CA.AvgPerCategory   
FROM Products AS P
JOIN CatAvg AS CA
ON P.CategoryID = CA.CategoryID
WHERE P.UnitPrice < CA.AvgPerCategory
GROUP BY P.ProductID, P.UnitPrice, 
    CA.CategoryID, CA.AvgPerCategory;




-- cw 3.

WITH AvgP AS (
    SELECT AVG(UnitPrice) AS AvgPrices 
    FROM Products
)
SELECT P.ProductID, P.UnitPrice, 
    AvgP.AvgPrices, P.UnitPrice - AvgP.AvgPrices as DiffPrices
FROM Products AS P
CROSS JOIN AvgP

-- sec solution
SELECT 
    ProductID, 
    UnitPrice,
    (SELECT AVG(UnitPrice) FROM Products) AS AvgPrices,
    UnitPrice - (SELECT AVG(UnitPrice) FROM Products) AS DiffPrices
FROM Products;


-- Dla każdego produktu podaj jego nazwę kategorii, 
-- nazwę produktu, cenę, średnią cenę wszystkich produktów 
-- danej kategorii oraz różnicę między ceną produktu a
-- średnią ceną wszystkich produktów danej kategorii

WITH CAT AS (
    SELECT C.CategoryID, AVG(P.UnitPrice) AS AvgPerCategory
    FROM Categories AS C
    JOIN Products AS P
    ON P.CategoryID = C.CategoryID
    GROUP BY C.CategoryID
)
SELECT P.CategoryID, CAT.AvgPerCategory, 
P.ProductID, P.UnitPrice, CAT.AvgPerCategory - P.UnitPrice AS Diff 
FROM Products AS P
JOIN CAT 
ON CAT.CategoryID = P.CategoryID


-- cw 4

-- . Podaj łączną wartość 
-- zamówienia o numerze 1025 (uwzględnij cenę za przesyłkę)

SELECT OrderID, (
    SELECT SUM(UnitPrice*Quantity*(1-Discount))
    FROM [Order Details]
    WHERE OrderID = 10250
) + Freight AS TotalPrice
FROM Orders
WHERE OrderID = 10250

--Podaj łączną wartość zamówień każdego 
-- zamówienia (uwzględnij cenę za przesyłkę)

WITH TP AS (
    SELECT OrderID ,
        SUM(UnitPrice*Quantity*(1-Discount)) AS TotalPrice
    FROM [Order Details]
    GROUP BY OrderID
)
SELECT O.OrderID, TP.TotalPrice + o.Freight as TotalPrice
FROM Orders AS O
JOIN TP 
ON TP.OrderID = O.OrderID


-- Czy są jacyś klienci którzy nie złożyli 
-- żadnego zamówienia w 1997 roku, jeśli tak
-- to pokaż ich dane adresowe

SELECT CustomerID, Address
FROM Customers 
WHERE CustomerID NOT IN (
    SELECT C.CustomerID
    FROM Customers AS C
    JOIN Orders AS O
    ON O.CustomerID = C.CustomerID AND YEAR(OrderDate) = 1997
)

-- Podaj produkty kupowane przez 
-- więcej niż jednego klienta

SELECT P.ProductID, P.ProductName, CT.CustomerCount
FROM Products AS P
JOIN (
    SELECT OD.ProductID, COUNT(C.CustomerID) AS CustomerCount
    FROM Orders AS O
    JOIN [Order Details] AS OD
    ON O.OrderID = OD.OrderID
    JOIN Customers AS C
    ON O.CustomerID = C.CustomerID
    GROUP BY OD.ProductID
) AS CT
ON P.ProductID = CT.ProductID
WHERE CT.CustomerCount > 1;


-- cw 5

-- Dla każdego pracownika (imię i nazwisko)
-- podaj łączną wartość zamówień
-- obsłużonych przez tego pracownika 
-- (przy obliczaniu wartości zamówień
-- uwzględnij cenę za przesyłkę

WITH TP AS (
    SELECT OD.OrderID,
        SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalPrice
    FROM [Order Details] AS OD
    GROUP BY OD.OrderID
)
SELECT O.EmployeeID, SUM(TP.TotalPrice + O.Freight) AS Total
FROM Orders AS O
JOIN TP
ON TP.OrderID = O.OrderID
GROUP BY O.EmployeeID;


-- Który z pracowników obsłużył najaktywniejszy 
-- (obsłużył zamówienia o największej wartości) 
-- w 1997r, podaj imię i nazwisko takiego pracownika

WITH TP AS (
    SELECT OD.OrderID,
        SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalPrice
    FROM [Order Details] AS OD
    GROUP BY OD.OrderID
)
SELECT TOP 1 E.EmployeeID, E.FirstName, E.LastName, SUM(TP.TotalPrice + O.Freight) AS Total
FROM Employees AS E
LEFT JOIN Orders AS O
ON O.EmployeeID = E.EmployeeID
JOIN TP
ON TP.OrderID = O.OrderID AND YEAR(O.OrderDate) = 1997
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY Total DESC;


-- Ogranicz wynik z pkt 1 tylko do pracowników
-- a) którzy mają podwładnych
-- b) którzy nie mają podwładnych

-- a)
WITH TP AS (
    SELECT OD.OrderID,
        SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalPrice
    FROM [Order Details] AS OD
    GROUP BY OD.OrderID
)
SELECT O.EmployeeID, SUM(TP.TotalPrice + O.Freight) AS Total
FROM Orders AS O
JOIN TP
ON TP.OrderID = O.OrderID
WHERE O.EmployeeID IN (

    SELECT DISTINCT ReportsTo
    FROM Employees
    WHERE ReportsTo IS NOT NULL
)
GROUP BY O.EmployeeID;


-- b)
WITH TP AS (
    SELECT OD.OrderID,
        SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalPrice
    FROM [Order Details] AS OD
    GROUP BY OD.OrderID
)
SELECT O.EmployeeID, SUM(TP.TotalPrice + O.Freight) AS Total
FROM Orders AS O
JOIN TP
ON TP.OrderID = O.OrderID
WHERE O.EmployeeID NOT IN (

    SELECT DISTINCT ReportsTo
    FROM Employees
    WHERE ReportsTo IS NOT NULL
)
GROUP BY O.EmployeeID;


-- Zmodyfikuj rozwiązania z pkt 3 tak aby dla pracowników pokazać jeszcze datę
-- ostatnio obsłużonego zamówienia

-- a) 
WITH TP AS (
    SELECT OD.OrderID,
        SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalPrice
    FROM [Order Details] AS OD
    GROUP BY OD.OrderID
)
SELECT O.EmployeeID, SUM(TP.TotalPrice + O.Freight) AS Total, 
    MAX(O.OrderDate) AS RecentDate
FROM Orders AS O
JOIN TP
ON TP.OrderID = O.OrderID
WHERE O.EmployeeID IN (

    SELECT DISTINCT ReportsTo
    FROM Employees
    WHERE ReportsTo IS NOT NULL
)
GROUP BY O.EmployeeID;


-- b)
WITH TP AS (
    SELECT OD.OrderID,
        SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalPrice
    FROM [Order Details] AS OD
    GROUP BY OD.OrderID
)
SELECT O.EmployeeID, SUM(TP.TotalPrice + O.Freight) AS Total,
    MAX(O.OrderDate) AS RecentDate
FROM Orders AS O
JOIN TP
ON TP.OrderID = O.OrderID
WHERE O.EmployeeID NOT IN (

    SELECT DISTINCT ReportsTo
    FROM Employees
    WHERE ReportsTo IS NOT NULL
)
GROUP BY O.EmployeeID;