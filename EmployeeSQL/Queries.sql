-- ** Testing the tables ** --
/*
Drop table Dept_emp;
Drop table Titles;
Drop table Salaries;
Drop table Departments;
Drop table Employees;
Drop table Dept_manager;

select * from Departments;


-- ** Create Table Employees ** --
CREATE TABLE Employees (
    emp_no 			INTEGER 	PRIMARY KEY NOT NULL,
    emp_title_id 	VARCHAR(10)   			NOT NULL,
    birth_date 		DATE   					NOT NULL,
    first_name 		VARCHAR   				NOT NULL,
    last_name 		VARCHAR   				NOT NULL,
    sex 			VARCHAR   				NOT NULL,
    hire_date 		DATE   					NOT NULL,
	FOREIGN KEY(emp_title_id)REFERENCES Titles (title_id));
	
-- ** Create Table Titles ** --
CREATE TABLE Titles (
    title_id 		VARCHAR(10) PRIMARY KEY	NOT NULL,
    title    		VARCHAR    				NOT NULL);
	
-- ** Create Table Salaries ** --
CREATE TABLE Salaries (
    emp_no 			INTEGER     PRIMARY KEY	NOT NULL,
	salary 			INTEGER   	   			NOT NULL,
	FOREIGN KEY(emp_no)REFERENCES Employees (emp_no));
	
-- ** Create Table Departments ** --
CREATE TABLE Departments (
    dept_no   		VARCHAR(10) PRIMARY KEY NOT NULL,
    dept_name 		VARCHAR 				NOT NULL);
	
-- ** Create Table Dept_emp ** --
CREATE TABLE Dept_emp (
    emp_no 			INTEGER      			NOT NULL,
    dept_no 		VARCHAR(10) 			NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY(emp_no)REFERENCES Employees(emp_no),
	FOREIGN KEY(dept_no)REFERENCES Departments (dept_no));

-- ** Create Table Dept_manager ** --
CREATE TABLE Dept_manager (
    dept_no 		VARCHAR   				NOT NULL,
    emp_no 			INTEGER   				NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY(dept_no) REFERENCES Departments (dept_no),
	FOREIGN KEY(emp_no)  REFERENCES Employees (emp_no));
	*/

--------------------------------------------------------------------------------------------

--List the employee number, last name, first name, sex, and salary of each employee. 
SELECT Employees.emp_no     as "Employee number",
	   Employees.last_name  as "Last Name",
	   Employees.first_name as "First Name",
	   Employees.sex 		as "Sex",
	   Salaries.salary      as "Salary"
FROM   Employees 
JOIN Salaries on Employees.emp_no = Salaries.emp_no;


--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM   Employees
WHERE  TO_CHAR(hire_date, 'YYYY') LIKE '1986%';


--List the manager of each department along with their department number, department name, employee number, last name, and first name.
--	   (Table)		(Column)		(New Name)
SELECT Dept_manager.dept_no 	as "Department Number",
	   Departments.dept_name	as "Department Name",
	   Dept_manager.emp_no 		as "Employee Number",
	   Employees.last_name		as "Last Name",
	   Employees.first_name		as "First Name"
	   
-- 	   (Table to Get the info from)
FROM   Dept_manager
--	   (Join different tables with their keys to show the desired results)
JOIN   Departments  ON Dept_manager.dept_no = Departments.dept_no
JOIN   Employees 	ON Dept_manager.emp_no = Employees.emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
--	   (Table)		(Column)		(New Name)
SELECT Dept_emp.dept_no 		as "Department Number",
	   Dept_emp.emp_no			as "Employee Number",
	   Employees.last_name		as "Last Name",
	   Employees.first_name		as "First Name",
	   Departments.dept_name	as "Department Name"
-- 	   (Table to Get the info from)
FROM   Dept_emp
--	   (Join different tables with their keys to show the desired results)
JOIN   Employees 	ON Dept_emp.emp_no = Employees.emp_no
JOIN   Departments	ON Dept_emp.dept_no= Departments.dept_no;

--List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM   Employees
WHERE  first_name = 'Hercules' AND last_name LIKE 'B%';


--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT Employees.emp_no		   as "Employee Number",
	   Employees.last_name     as "Employee Last name",
	   Employees.first_name    as "Employee First name"
FROM   Employees
JOIN   Dept_emp    ON Employees.emp_no = Dept_emp.emp_no
JOIN   Departments ON Dept_emp.dept_no = Departments.dept_no
WHERE  Departments.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT Employees.emp_no		   as "Employee Number",
	   Employees.last_name     as "Employee Last name",
	   Employees.first_name    as "Employee First name",
	   Departments.dept_name   as "Department Name"
FROM   Employees
JOIN   Dept_emp    ON Employees.emp_no = Dept_emp.emp_no
JOIN   Departments ON Dept_emp.dept_no = Departments.dept_no
WHERE  Departments.dept_name = 'Sales' or Departments.dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT 		last_name, 
COUNT		(last_name) 	   as "Frequency counts Last names"
FROM 		Employees 
GROUP BY 	last_name
ORDER BY 	"Frequency counts Last names" DESC;