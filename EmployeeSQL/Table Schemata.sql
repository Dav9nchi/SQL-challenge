-- ** Testing the tables ** --
/*
Drop table Dept_emp;
Drop table Titles;
Drop table Salaries;
Drop table Departments;
Drop table Employees;
Drop table Dept_manager;

select * from Departments;
*/

-- ** Create Table Employees ** --
CREATE TABLE Employees (
    emp_no 		INTEGER     PRIMARY KEY 		NOT NULL,
    emp_title_id 	VARCHAR(10)   				NOT NULL,
    birth_date 		DATE   					NOT NULL,
    first_name 		VARCHAR   				NOT NULL,
    last_name 		VARCHAR   				NOT NULL,
    sex 			VARCHAR   			NOT NULL,
    hire_date 		DATE   					NOT NULL,
	FOREIGN KEY(emp_title_id)REFERENCES Titles (title_id));
	
-- ** Create Table Titles ** --
CREATE TABLE Titles (
    title_id 		VARCHAR(10) PRIMARY KEY			NOT NULL,
    title    		VARCHAR    				NOT NULL);
	
-- ** Create Table Salaries ** --
CREATE TABLE Salaries (
    emp_no 		INTEGER     PRIMARY KEY			NOT NULL,
    salary 		INTEGER   	   			NOT NULL,
	FOREIGN KEY(emp_no)REFERENCES Employees (emp_no));
	
-- ** Create Table Departments ** --
CREATE TABLE Departments (
    dept_no   		VARCHAR(10) PRIMARY KEY 		NOT NULL,
    dept_name 		VARCHAR 				NOT NULL);
	
-- ** Create Table Dept_emp ** --
CREATE TABLE Dept_emp (
    emp_no 		INTEGER      				NOT NULL,
    dept_no 		VARCHAR(10) 				NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY(emp_no)REFERENCES Employees(emp_no),
	FOREIGN KEY(dept_no)REFERENCES Departments (dept_no));

-- ** Create Table Dept_manager ** --
CREATE TABLE Dept_manager (
    dept_no 		VARCHAR   				NOT NULL,
    emp_no 		INTEGER   				NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY(dept_no) REFERENCES Departments (dept_no),
	FOREIGN KEY(emp_no)  REFERENCES Employees (emp_no));
