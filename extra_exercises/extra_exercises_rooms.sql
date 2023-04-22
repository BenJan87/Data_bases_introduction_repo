-- to create databases in Microsoft SQL server

CREATE TABLE pokoje (
 id INT IDENTITY(1,1) PRIMARY KEY,
 nazwa VARCHAR(20) NULL
);


CREATE TABLE okresy (
 id INT IDENTITY(1,1) PRIMARY KEY,
 nazwa VARCHAR(20) NULL,
 data_od DATE NULL,
 data_do DATE NULL
);


CREATE TABLE ceny (
 id INT IDENTITY(1,1) PRIMARY KEY,
 okresy_id INT NOT NULL,
 pokoje_id INT NOT NULL,
 cena DECIMAL(10,2) NULL,
 CONSTRAINT ceny_FK1 FOREIGN KEY(pokoje_id) REFERENCES pokoje(id),
 CONSTRAINT ceny_FK2 FOREIGN KEY(okresy_id) REFERENCES okresy(id),
 INDEX ceny_FKIndex1(pokoje_id),
 INDEX ceny_FKIndex2(okresy_id)
);

-- example data for tables:

INSERT INTO pokoje (nazwa) VALUES
('ladny'),
('piekny'),
('brzydki'),
('duzy'),
('niebieski');

INSERT INTO okresy (nazwa, data_od, data_do) VALUES
('wrzesień 2021', '2021-09-01', '2021-09-30'),
('październik 2021', '2021-10-01', '2021-10-31'),
('listopad 2021', '2021-11-01', '2021-11-30'),
('grudzień 2021', '2021-12-01', '2021-12-31'),
('styczeń 2022', '2022-01-01', '2022-01-31'),
('luty 2022', '2022-02-01', '2022-02-28'),
('marzec 2022', '2022-03-01', '2022-03-31'),
('kwiecień 2022', '2022-04-01', '2022-04-30'),
('maj 2022', '2022-05-01', '2022-05-31'),
('czerwiec 2022', '2022-06-01', '2022-06-30'),
('lipiec 2022', '2022-07-01', '2022-07-31'),
('sierpień 2022', '2022-08-01', '2022-08-31'),
('wrzesień 2022', '2022-09-01', '2022-09-30'),
('październik 2022', '2022-10-01', '2022-10-31'),
('listopad 2022', '2022-11-01', '2022-11-30'),
('grudzień 2022', '2022-12-01', '2022-12-31'),
('styczeń 2023', '2023-01-01', '2023-01-31'),
('luty 2023', '2023-02-01', '2023-02-28'),
('marzec 2023', '2023-03-01', '2023-03-31'),
('kwiecień 2023', '2023-04-01', '2023-04-30');

INSERT INTO ceny (okresy_id, pokoje_id, cena)
VALUES 
(1, 1, 100.00),
(2, 1, 90.00),
(3, 1, 80.00),
(4, 1, 75.00),
(5, 1, 70.00),
(6, 1, 80.00),
(7, 1, 90.00),
(8, 1, 95.00),
(9, 1, 110.00),
(10, 1, 120.00),
(11, 1, 130.00),
(12, 1, 140.00),
(13, 1, 150.00),
(14, 1, 160.00),
(15, 1, 180.00),
(16, 1, 190.00),
(17, 1, 200.00),
(18, 1, 180.00),
(19, 1, 150.00),
(20, 1, 120.00),
(1, 2, 140.00),
(2, 2, 120.00),
(3, 2, 100.00),
(4, 2, 90.00),
(5, 2, 80.00),
(6, 2, 70.00),
(7, 2, 80.00),
(8, 2, 95.00),
(9, 2, 110.00),
(10, 2, 120.00),
(11, 2, 130.00),
(12, 2, 140.00),
(13, 2, 150.00),
(14, 2, 160.00),
(15, 2, 180.00),
(16, 2, 190.00),
(17, 2, 200.00),
(18, 2, 180.00),
(19, 2, 150.00),
(20, 2, 120.00),
(1, 3, 110.00),
(2, 3, 90.00),
(3, 3, 80.00),
(4, 3, 75.00),
(5, 3, 70.00),
(6, 3, 80.00),
(7, 3, 90.00),
(8, 3, 95.00),
(9, 3, 100.00),
(10, 3, 120.00),
(11, 3, 140.00),
(12, 3, 160.00),
(13, 3, 170.00),
(14, 3, 180.00),
(15, 3, 190.00),
(16, 3, 200.00),
(17, 3, 180.00),
(18, 3, 150.00),
(19, 3, 120.00),
(20, 3, 90.00),
(1, 4, 90.00),
(2, 4, 70.00),
(3, 4, 60.00),
(4, 4, 55.00),
(5, 4, 50.00),
(6, 4, 60.00),
(7, 4, 70.00),
(8, 4, 75.00),
(9, 4, 80.00),
(10, 4, 100.00),
(11, 4, 120.00),
(12, 4, 140.00),
(13, 4, 150.00),
(14, 4, 160.00),
(15, 4, 170.00),
(16, 4, 180.00),
(17, 4, 160.00),
(18, 4, 130.00),
(19, 4, 100.00),
(20, 4, 70.00),
(1, 5, 130.00),
(2, 5, 100.00),
(3, 5, 90.00),
(4, 5, 85.00),
(5, 5, 80.00),
(6, 5, 90.00),
(7, 5, 100.00),
(8, 5, 105.00),
(9, 5, 110.00),
(10, 5, 130.00),
(11, 5, 150.00),
(12, 5, 170.00),
(13, 5, 180.00),
(14, 5, 190.00),
(15, 5, 200.00),
(16, 5, 220.00),
(17, 5, 200.00),
(18, 5, 170.00),
(19, 5, 140.00),
(20, 5, 100.00);




SELECT * FROM pokoje
SELECT * FROM okresy
SELECT * FROM ceny

-- the following query returns the total value of room in given period of time,
-- so for example: what is the cost in 'niebieski room' between the 2023-01-01 and 2023-02-01
-- (data format is YYYY-MM-DD and also all dates are inclusive - so no other prices are colliding)



