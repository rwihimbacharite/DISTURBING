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