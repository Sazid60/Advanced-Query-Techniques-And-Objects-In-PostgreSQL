# Advanced-Query-Techniques-And-Objects-In-PostgreSQL

GitHub Link: https://github.com/Apollo-Level2-Web-Dev/dbms-postgres

## 10-1 Query Practice: Part 3

```sql
CREATE TABLE orders(
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
)

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(101, '2025-05-01', 199.99),
(102, '2025-05-02', 89.50),
(103, '2025-05-03', 145.00),
(104, '2025-05-04', 320.75),
(101, '2025-05-05', 25.99),
(105, '2025-05-06', 470.00),
(102, '2025-05-07', 129.49),
(106, '2025-05-08', 250.00),
(107, '2025-05-09', 78.90),
(108, '2025-05-10', 199.00),
(102, '2024-03-07', 129.49),
(106, '2024-02-08', 250.00),
(107, '2024-01-09', 78.90),
(108, '2024-06-10', 199.00);


TRUNCATE TABLE orders
-- Find customers who have placed more than 2 orders and calculate the total amount spent by each of these customers.

SELECT customer_id, SUM(total_amount) as total_order_amount FROM orders
GROUP BY customer_id
HAVING count(order_id) >1;

-- Find the total amount of orders placed each month in the year 2022.

SELECT extract(month FROM order_date) as order_months, count(order_date) FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2024
GROUP BY order_months;

```

## 10-2 Exploring Subqueries

- `SUBQUERIES` : A subquery is a nested query within another sql statement
- and under which the subquery is written is called `Primary Query/ Main Query`

#### Why/when do we need subqueries

- Retrieve all employees whose salary is greater than the highest of the hr department.
- here two things are required :
  1. first find the hr department highest salary
  2. compare the Hr department highest salary with all employee salary

```sql
-- SELECT department_name, max(salary) from employees
-- GROUP BY department_name
-- HAVING department_name = 'HR';

SELECT  max(salary) from employees where department_name = 'HR'


SELECT * FROM employees WHERE salary > 63000;
```

- This is not right. we haver to use subqueries. since we will not know to what we have to compare.

```sql
SELECT * FROM employees WHERE salary > (SELECT  max(salary) from employees where department_name = 'HR')
```

- Here `SELECT * FROM employees WHERE salary > (SELECT  max(salary) from employees where department_name = 'HR')` takes a lot of data and returns one data. This is called `SCALER SUB QUERIES`.
- we have to take care where we use and how we use.

#### Sub queries can return some values

1. Can return single value (row-1,column-1)
2. Can return multiple rows
3. Can Return a single column

#### where we will use sub queries

| Clause   | Can Use Subquery? | Example                                                                                                               | Notes                                                          |
| -------- | ----------------- | --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| `SELECT` | ✅ Yes            | `SELECT (SELECT MAX(salary) FROM employees) AS max_salary`                                                            | Subquery returns a single value used in the SELECT output      |
| `FROM`   | ✅ Yes            | `SELECT * FROM (SELECT * FROM orders WHERE amount > 100) AS big_orders`                                               | Subquery returns a derived table (must be aliased)             |
| `WHERE`  | ✅ Yes            | `SELECT name FROM employees WHERE dept_id IN (SELECT id FROM departments)`                                            | Most common use case for filtering data based on another query |
| `JOIN`   | ✅ Yes            | `SELECT e.name, d.name FROM employees e JOIN (SELECT * FROM departments WHERE location = 'NY') d ON e.dept_id = d.id` | Less common but useful when joining with filtered sub-tables   |

- When we will use `subqueries` in `SELECT` we have to take care of that it should must return a single value.
