-- cw1
-- select the names and phone numbers of the clients, whom were delivered the packeges by United Package
-- Wybierz nazwy i numery telefonów klientów, którym w 1997 roku przesyłki dostarczała firma United Package.

SELECT P.ProductID, P.ProductName ,(
    SELECT MAX(Quantity) AS MaxQuantity
    FROM [Order Details] AS OD
    WHERE P.ProductID = OD.ProductID
) AS MaxValue
FROM Products AS P

SELECT DISTINCT productid, quantity
FROM [order details] AS ord1
WHERE quantity = ( SELECT MAX(quantity)
FROM [order details] AS ord2
WHERE ord1.productid =
ord2.productid )