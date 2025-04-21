# SQL Window Functions Analysis

## Team Members
- [MIGISHA RWIHIMBA CHARITE]
- [NIRERE ANGELIQUE]

## Overview
This project demonstrates the use of SQL Window Functions to perform various analytical queries on an employee dataset. Window functions allow us to perform calculations across rows of data that are related to the current row, providing powerful analytical capabilities.

## Database Schema
We've created a simple employee database with the following structure:

```sql
CREATE TABLE Employees(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2),
    hiring_date DATE
);
```

Our dataset contains 14 employees across 3 departments (HR, IT, and Finance) with varying salaries and hiring dates.
## Window Functions Implemented

### 1. Compare Values with Previous or Next Records (LAG/LEAD)

This query compares each employee's salary with their previous and next colleagues within the same department.

```sql
SELECT e.*,
    LAG(salary) OVER (PARTITION BY dept_name ORDER BY emp_id) AS prev_emp_salary,
    LEAD(salary) OVER (PARTITION BY dept_name ORDER BY emp_id) AS next_emp_salary
FROM EMPLOYEES e;
```![LAG/LEAD](1.png)
![NEXT](2.png)
![next1](3.png)
![next 2](4.png)
![next 3](5.png)
