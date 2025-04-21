CREATE TABLE Employees(
        emp_id INT PRIMARY KEY,
        emp_name VARCHAR(100) NOT NULL,
        dept_name VARCHAR(100) NOT NULL,
        salary DECIMAL(10,2));

INSERT INTO EMPLOYEES(emp_id,emp_name,dept_name,salary)
VALUES(27300,'Mukunzi kevin','HR',10000);

INSERT INTO EMPLOYEES VALUES(27301,'Murekezi Bruce','IT',15000);
INSERT INTO EMPLOYEES VALUES(27302,'Manzi vindic','IT',30000);
INSERT INTO EMPLOYEES VALUES(27303,'Murenzi David','Finance',15000);
INSERT INTO EMPLOYEES VALUES(27304,'Mukire Dovan','HR',20000);	
INSERT INTO EMPLOYEES VALUES(27305,'Mushime Derick','IT',15000);
INSERT INTO EMPLOYEES VALUES(27306,'Mutsinzi King','Finance',22000);
INSERT INTO EMPLOYEES VALUES(27307,'Shema Ronald','HR',35000);	
INSERT INTO EMPLOYEES VALUES(27308,'Rurangirwa Devin','IT',40000);	
INSERT INTO EMPLOYEES VALUES(27309,'Ntwali Christian','Finance',15000);
INSERT INTO EMPLOYEES VALUES(27310,'Murenzi David','IT',32000);
INSERT INTO EMPLOYEES VALUES(27311,'Mushyo Arnauld','IT',34000);
INSERT INTO EMPLOYEES VALUES(27312,'Cyogere Yvan','Finance',18000);
INSERT INTO EMPLOYEES VALUES(27313,'Muhire Jules','Finance',10000);	

 



ALTER TABLE EMPLOYEES
 ADD HIRING_DATE DATE;

UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-01-01','YYYY-MM-DD')
WHERE EMP_ID = 27300;

UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-01-05','YYYY-MM-DD')
WHERE EMP_ID = 27301;
UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-01-07','YYYY-MM-DD')
WHERE EMP_ID = 27302;

UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-01-01','YYYY-MM-DD')
WHERE EMP_ID = 27303;	

UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-01-13','YYYY-MM-DD')
WHERE EMP_ID = 27304;

UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-01-11','YYYY-MM-DD')
WHERE EMP_ID = 27305;

UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-01-17','YYYY-MM-DD')
WHERE EMP_ID = 27306;


UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-01-25','YYYY-MM-DD')
WHERE EMP_ID = 27307;	

UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-01-31','YYYY-MM-DD')
WHERE EMP_ID = 27308;	

UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-02-01','YYYY-MM-DD')
WHERE EMP_ID = 27309;

UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-02-05','YYYY-MM-DD')
WHERE EMP_ID = 27310;	

UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-02-10','YYYY-MM-DD')
WHERE EMP_ID = 27311;	


UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-02-14','YYYY-MM-DD')
WHERE EMP_ID = 27312;	

UPDATE EMPLOYEES
SET HIRING_DATE = TO_dATE('2025-02-20','YYYY-MM-DD')
WHERE EMP_ID = 27313;	


UPDATE EMPLOYEES
SET SALARY = 18000
WHERE EMP_ID = 27309;	

UPDATE EMPLOYEES
SET SALARY = 18000
WHERE EMP_ID = 27312;	




/*
Q1.0:
This query compares each employee's salary with their previous and next colleague (by employee ID) within the same department.
LAG() fetches the previous employee's salary,
LEAD() fetches the next employee's salary.
*/

select e.*,
lag(salary) over (partition by dept_name order by emp_id) as prev_emp_salary,
lead(salary) over (partition by dept_name order by emp_id) as next_emp_salary
from EMPLOYEES e;

-- Q1.1
/*
This query compares each employee's salary with the previous employee's salary within the same department (based on employee ID).
It uses LAG() to fetch the previous salary and a CASE statement to label whether the current salary is higher, lower, or the same.
*/

select e.*,
lag(salary) over (partition by dept_name order by emp_id) as prev_emp_salary,
case when e.salary > lag(salary) over (partition by dept_name order by emp_id) then 'Higher than the previous employee'
     when e.salary < lag(salary) over (partition by dept_name order by emp_id) then 'Lower than the previous employee'
     when e.salary = lag(salary) over (partition by dept_name order by emp_id) then 'same as previous employee'
end sal_range
from EMPLOYEES e;





/*
 Q2: Key difference between rank() and dense_rank():
This query lists all employees along with their salary-based rankings within each department.
It uses both RANK() and DENSE_RANK() to compare how ties are handled. While RANK() skips ranks after ties, DENSE_RANK() gives the same rank for ties but continues with the next consecutive number no gaps.
*/		

select e.*,
rank() over (partition by dept_name order by salary desc) as rnk,
dense_rank() over (partition by dept_name order by salary desc) as DENSE_rnk
from EMPLOYEES e;



/*
Q3:
This query retrieves the top 3 highest-paid employees from each department.
It uses the RANK() window function to assign a rank based on salary within
each department (PARTITION BY dept_name ORDER BY salary DESC),
and then filters to keep only those ranked 1 to 3.

*/

select * from(
select e.*,
rank() over (partition by dept_name order by salary desc) as rnk
from EMPLOYEES e) x
where x.rnk <= 3;


/*
Q4:
 Fetch the first 3 employees from each department to join the company based on the hiring date.
This query retrieves the first two employees who joined from each department, based on their hire date.
It uses a window function (ROW_NUMBER) to rank employees within each department by hire date,
and then filters to keep only the top two per department or group.
*/	
select * from(
select e.*,
row_number() over (partition by dept_name order by hiring_date ASC) as rn
from EMPLOYEES e) x
where x.rn <3;	


/*
Q5:
This query displays all employee records along with two additional columns:
dept_max_salary shows the highest salary within each department using MAX() OVER (PARTITION BY dept_name).
Overall_max_salary shows the highest salary across all employees using MAX() OVER() without partitioning.
*/

SELECT e.*,
       MAX(salary) OVER (PARTITION BY dept_name) AS dept_max_salary,
       MAX(salary) OVER () AS overall_max_salary
FROM EMPLOYEES e;

