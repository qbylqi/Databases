--  1. Write a stored procedure named increase_value that takes one
-- integer parameter and returns the parameter value increased by 10
CREATE OR REPLACE PROCEDURE increase_value(IN val INTEGER, OUT result INTEGER)
LANGUAGE plpgsql AS
$$
BEGIN
    result := val + 10;
END;
$$;


--  2. Create a stored procedure compare_numbers that takes two
-- integers and returns 'Greater', 'Equal', or 'Lesser' as an out
-- parameter, depending on the comparison result of these two
-- numbers
CREATE OR REPLACE PROCEDURE compare_numbers(IN num1 INTEGER, IN num2 INTEGER, OUT result VARCHAR)
LANGUAGE plpgsql AS
$$
BEGIN
    IF num1 > num2 THEN
        result := 'Greater';
    ELSIF num1 = num2 THEN
        result := 'Equal';
    ELSE
        result := 'Lesser';
    END IF;
END;
$$;


--  3. Write a stored procedure number_series that takes an integer n
-- and returns a series from 1 to n. Use a looping construct within
-- the procedure.
CREATE OR REPLACE PROCEDURE number_series(IN n INTEGER)
LANGUAGE plpgsql AS
$$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= n LOOP
        RAISE NOTICE 'Number: %', i;
        i := i + 1;
    END LOOP;
END;
$$;


--  4. Write a stored procedure find_employee that takes an
-- employee name as a parameter and returns the employee
-- details by performing a query.
CREATE OR REPLACE PROCEDURE find_employee(IN emp_name VARCHAR)
LANGUAGE plpgsql AS
$$
BEGIN
    
    RAISE NOTICE 'Employee Details: ';
    PERFORM * FROM employees WHERE name = emp_name;
END;
$$;


--  5. Develop a stored procedure list_products that returns a table
-- with product details from a given category
CREATE OR REPLACE PROCEDURE list_products(IN category_name VARCHAR)
LANGUAGE plpgsql AS
$$
BEGIN
    -- Запрос для получения данных о продуктах
    RAISE NOTICE 'Product Details: ';
    PERFORM * FROM products WHERE category = category_name;
END;
$$;


--  6. Create two stored procedures where the first procedure calls
-- the second one. For example, a procedure calculate_bonus
-- that calculates a bonus, and another procedure update_salary
-- that uses calculate_bonus to update the salary of an employee.
CREATE OR REPLACE PROCEDURE calculate_bonus(IN salary NUMERIC, OUT bonus NUMERIC)
LANGUAGE plpgsql AS
$$
BEGIN
    bonus := salary * 0.1; 
END;
$$;

CREATE OR REPLACE PROCEDURE update_salary(IN emp_id INTEGER)
LANGUAGE plpgsql AS
$$
DECLARE
    current_salary NUMERIC;
    bonus NUMERIC;
BEGIN
    
    SELECT salary INTO current_salary FROM employees WHERE id = emp_id;
    
    
    CALL calculate_bonus(current_salary, bonus);
    
    
    UPDATE employees SET salary = current_salary + bonus WHERE id = emp_id;
END;
$$;


--  7. Create a stored procedure complex_calculation
-- that accepts multiple parameters of various types (e.g., INTEGER, VARCHAR).
-- The main block should include at least two nested subblocks.
-- Each subblock should perform a distinct operation (e.g., string manipulation and a numeric computation).
-- The main block should then combine results from these subblocks in some way.
-- Return a final result that depends on both subblocks' outputs.
CREATE OR REPLACE PROCEDURE complex_calculation(IN num1 INTEGER, IN str1 VARCHAR, OUT result NUMERIC)
LANGUAGE plpgsql AS
$$
DECLARE
    processed_str VARCHAR;
    calculation_result NUMERIC;
BEGIN
    
    BEGIN
        processed_str := CONCAT(str1, '_processed');
    END;

    
    BEGIN
        calculation_result := num1 * 1.5;
    END;

    
    result := calculation_result + LENGTH(processed_str);
END;
$$;
