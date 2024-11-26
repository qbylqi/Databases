-- 1. The procedure increase_value increases the given integer by 10
CREATE OR REPLACE PROCEDURE increase_value(IN val INT, OUT result INT)
LANGUAGE plpgsql AS
$$
BEGIN
    result := val + 10;
END;
$$;

-- 2. The procedure compare_numbers compares two numbers and returns 'Greater', 'Equal', or 'Lesser'
CREATE OR REPLACE PROCEDURE compare_numbers(IN num1 INT, IN num2 INT, OUT result VARCHAR)
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

-- 3. The procedure number_series generates a series of numbers from 1 to n
CREATE OR REPLACE PROCEDURE number_series(IN n INT)
LANGUAGE plpgsql AS
$$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= n LOOP
        RAISE NOTICE 'Number: %', i;  -- Outputs the current number
        i := i + 1;
    END LOOP;
END;
$$;

-- 4. The procedure find_employee finds an employee by name and outputs their details
CREATE OR REPLACE PROCEDURE find_employee(IN emp_name VARCHAR)
LANGUAGE plpgsql AS
$$
BEGIN
    -- Query to get employee details
    RAISE NOTICE 'Employee Details: ';
    PERFORM * FROM employees WHERE name = emp_name;
END;
$$;

-- 5. The procedure list_products returns a table with product details from a given category
CREATE OR REPLACE PROCEDURE list_products(IN category_name VARCHAR)
LANGUAGE plpgsql AS
$$
BEGIN
    -- Query to get product details from the specified category
    RAISE NOTICE 'Product Details: ';
    PERFORM * FROM products WHERE category = category_name;
END;
$$;

-- 6. The procedure calculate_bonus calculates a bonus, and the procedure update_salary updates an employee's salary
CREATE OR REPLACE PROCEDURE calculate_bonus(IN salary NUMERIC, OUT bonus NUMERIC)
LANGUAGE plpgsql AS
$$
BEGIN
    bonus := salary * 0.1;  -- Bonus is 10% of the salary
END;
$$;

CREATE OR REPLACE PROCEDURE update_salary(IN emp_id INT)
LANGUAGE plpgsql AS
$$
DECLARE
    current_salary NUMERIC;
    bonus NUMERIC;
BEGIN
    -- Get the current salary of the employee
    SELECT salary INTO current_salary FROM employees WHERE id = emp_id;
    
    -- Calculate the bonus
    CALL calculate_bonus(current_salary, bonus);
    
    -- Update the salary with the bonus
    UPDATE employees SET salary = current_salary + bonus WHERE id = emp_id;
END;
$$;

-- 7. The procedure complex_calculation performs multiple operations (string manipulation and numeric computation) and returns the final result
CREATE OR REPLACE PROCEDURE complex_calculation(IN num1 INT, IN str1 VARCHAR, OUT result NUMERIC)
LANGUAGE plpgsql AS
$$
DECLARE
    processed_str VARCHAR;
    calculation_result NUMERIC;
BEGIN
    -- Nested block for string manipulation
    BEGIN
        processed_str := CONCAT(str1, '_processed');
    END;

    -- Nested block for numeric computation
    BEGIN
        calculation_result := num1 * 1.5;  -- Multiplies the number by 1.5
    END;

    -- Final result
    result := calculation_result + LENGTH(processed_str);  -- Summing the computations
END;
$$;
