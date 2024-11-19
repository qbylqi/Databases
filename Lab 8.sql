-- 1.
CREATE DATABASE lab8;
-- 2.
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,         
    name VARCHAR(50),                    
    city VARCHAR(50),                   
    commission DECIMAL(5, 2)            
);
INSERT INTO salesman (salesman_id, name, city, commission)
VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Diego', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,        
    cust_name VARCHAR(50),              
    city VARCHAR(50),                    
    grade INT,                           
    salesman_id INT,                     
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 200, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,              
    purch_amt DECIMAL(10, 2),           
    ord_date DATE,                       
    customer_id INT,                    
    salesman_id INT,                     
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id), 
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)   
);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001);

-- 3. 
CREATE ROLE junior_dev WITH LOGIN;

-- 4. 
CREATE VIEW ny_salesmen AS
SELECT *
FROM salesman
WHERE city = 'New York';

GRANT ALL PRIVILEGES ON ny_salesmen TO junior_dev;

-- 5. 
CREATE VIEW order_details AS
SELECT o.ord_no, o.purch_amt, o.ord_date, c.cust_name, s.name AS salesman_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN salesman s ON o.salesman_id = s.salesman_id;


GRANT ALL PRIVILEGES ON order_details TO junior_dev;

-- 6. 
CREATE VIEW highest_grade_customers AS
SELECT *
FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON highest_grade_customers TO junior_dev;

-- 7. 
CREATE VIEW salesman_count_by_city AS
SELECT city, COUNT(*) AS salesman_count
FROM salesman
GROUP BY city;

-- 8. 
CREATE VIEW salesmen_with_multiple_customers AS
SELECT s.salesman_id, s.name, COUNT(c.customer_id) AS customer_count
FROM salesman s
JOIN customers c ON s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name
HAVING COUNT(c.customer_id) > 1;

-- 9. 
CREATE ROLE intern;
GRANT junior_dev TO intern;
