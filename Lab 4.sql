CREATE DATABASE Lab4;
-- Создание таблицы Warehouses
CREATE TABLE Warehouses (
    code SERIAL PRIMARY KEY,
    location VARCHAR(255),
    capacity INTEGER
);

-- Создание таблицы Boxes
CREATE TABLE Boxes (
    code CHAR(4) PRIMARY KEY,
    contents VARCHAR(255),
    value REAL,
    warehouse INTEGER REFERENCES Warehouses(code)
);

-- Вставка данных в таблицу Warehouses
INSERT INTO Warehouses (location, capacity) VALUES
('Chicago', 3),
('New York', 7),
('Los Angeles', 5),
('San Francisco', 8);

-- Вставка данных в таблицу Boxes
INSERT INTO Boxes (code, contents, value, warehouse) VALUES
('DMN7', 'Rocks', 180, 3),
('4RHP', 'Rocks', 250, 4),
('4TR3', 'Scissors', 190, 4),
('7G3H', 'Rocks', 200, 1),
('BJN6', 'Papers', 75, 1),
('8NVU', 'Papers', 50, 3),
('9JGF', 'Papers', 175, 2),
('LL08', 'Rocks', 140, 4),
('P0H6', 'Scissors', 125, 1),
('P2T6', 'Scissors', 150, 2),
('TU55', 'Papers', 90, 5);
SELECT * FROM Warehouses;
SELECT * FROM Boxes WHERE value > 150;
SELECT DISTINCT contents FROM Boxes;
SELECT warehouse, COUNT(*) AS box_count
FROM Boxes
GROUP BY warehouse;
SELECT warehouse, COUNT(*) AS box_count
FROM Boxes
GROUP BY warehouse
HAVING COUNT(*) > 2;
INSERT INTO Warehouses (location, capacity) VALUES ('New York', 3);
INSERT INTO Boxes (code, contents, value, warehouse)
VALUES ('H5RT', 'Papers', 200, 2);
UPDATE Boxes
SET value = value * 0.85
WHERE code = (
    SELECT code FROM Boxes
    ORDER BY value DESC
    LIMIT 1 OFFSET 2
);
DELETE FROM Boxes WHERE value < 150;
DELETE FROM Boxes
WHERE warehouse = (SELECT code FROM Warehouses WHERE location = 'New York')
RETURNING *;


