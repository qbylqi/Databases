-- 1
SELECT * FROM countries WHERE name = 'string';
CREATE INDEX idx_countries_name ON countries(name);

-- 2
SELECT * FROM employees WHERE name = 'string' AND surname = 'string';
CREATE INDEX idx_employees_name_surname ON employees(name, surname);

-- 3
SELECT * FROM employees WHERE salary < value1 AND salary > value2;
CREATE INDEX idx_employees_salary ON employees(salary);

-- 4
SELECT * FROM employees WHERE substring(name FROM 1 for 4) = 'abcd';


CREATE INDEX idx_employees_name_substring ON employees((substring(name FROM 1 FOR 4)));


-- 5
SELECT * FROM employees e JOIN departments d ON d.department_id = e.department_id
    WHERE d.budget > value2 AND e.salary < value2;

CREATE INDEX idx_employee_department_id ON employees(department_id);
CREATE INDEX idx_department_department_id ON departments(department_id);
CREATE INDEX idx_department_budget ON departments(budget);
CREATE INDEX idx_employee_salary ON employees(salary);
