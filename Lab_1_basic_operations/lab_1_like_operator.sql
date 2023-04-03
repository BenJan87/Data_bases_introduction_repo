-- Nortwind 2

-- All products in bottles:
select * 
from Products
where QuantityPerUnit like '%bottle%';


-- All employees' titles, where their names statrs with
-- the letter from B to L:
select FirstName, LastName, Title 
from Employees
where LastName like '[B-L]%';


-- All employees' titles, where their names statrs with
-- the letter B or L:

select FirstName, LastName, Title 
from Employees
where LastName like '[BL]%';


-- Categories, which contain coma:

select CategoryName, Description
from Categories
where Description like '%,%'

-- Clients, which have 'store' somewhere

select *
from Customers
where CompanyName
like '%store%'