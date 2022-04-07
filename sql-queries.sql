
DROP TABLE Job;
CREATE TABLE Job (
    job_id serial PRIMARY KEY,
    job_title varchar(100)
);

DROP TABLE Department;
CREATE TABLE Department(
    department_id serial primary key,
    department_name varchar(50)
);


DROP TABLE Salary;
CREATE TABLE Salary(
    salary_id serial PRIMARY KEY,
    salary INT
);

DROP TABLE Location;
CREATE TABLE Location(
    location_id serial PRIMARY KEY,
    location varchar(50),
    address varchar(100),
    city varchar(50),
    state varchar(2)
);

DROP TABLE education_level;
CREATE TABLE education_level(
    edu_id serial PRIMARY KEY,
    education_level varchar(50)

);


DROP TABLE Employment;
CREATE TABLE Employment (
    emp_id varchar(8),
    start_dt date,
    end_dt date,
    manager_id varchar(8),
    location_id int,
    edu_id int,
    department_id int,
    salary_id int,
    job_id int);


DROP TABLE Employee;
CREATE TABLE Employee (
    emp_id varchar(8),
    emp_name varchar(50),
    email varchar(100),
    hire_dt date
    PRIMARY KEY (emp_id));


INSERT INTO Job(job_title)
(SELECT DISTINCT
 job_title
 FROM proj_stg
);

INSERT INTO Department(department_name)
(SELECT DISTINCT
 department_nm
 FROM proj_stg
);

INSERT INTO Salary(salary)
(SELECT DISTINCT
 salary
 FROM proj_stg
);

INSERT INTO Location(location,address,city,state)
(SELECT DISTINCT
 location,
 address,
 city,
 state
 FROM proj_stg
);

INSERT INTO education_level(education_level)
(SELECT DISTINCT
 education_lvl
 FROM proj_stg
);


INSERT INTO Employment (Emp_ID,start_dt,end_dt,manager_id,location_id,edu_id,department_id,salary_id,job_id)
(SELECT a.Emp_ID,a.start_dt,a.end_dt,
 b.emp_id as manager_id,l.location_id,e.edu_id,d.department_id,s.salary_id,j.job_id
 FROM proj_stg a
 left join proj_stg b on a.manager = b.emp_nm
 left join location l on a.location = l.location
 left join education_level e on a.education_lvl = e.education_level
 left join department d on a.department_nm = d.department_name
 left join salary s on a.salary = s.salary
 left join job j on a.job_title = j.job_title
);

INSERT INTO Employee (Emp_ID,emp_name,email,hire_dt)
(SELECT Emp_ID, EMP_NM,email,hire_dt
 FROM proj_stg
);

--QUESTION 1
SELECT e.emp_name, j.job_title, d.department_name
from employee e
join department d on e.department_id = d.department_id
join job j on e.job_id = j.job_id;

--QUESTION 2

INSERT INTO Job (job_title)
(select 'Web Programmer');


--QUESTION 3
UPDATE Job
SET job_title = 'Web Developer'
WHERE job_title = 'Web Programmer';

--QUESTION 4
DELETE FROM Job
WHERE job_title = 'Web Developer';

--QUESTION 5
select d.department_name, count(distinct e.emp_id) Volume
from employee e
join department d on e.department_id = d.department_id
group by d.department_name;

--QUESTION 6
select e.emp_name,j.job_title,d.department_name,m.emp_name as manager_name,e.start_dt,e.end_dt
from employee e
join job j on e.job_id = j.job_id
join department d on e.department_id = d.department_id
join employee m on e.manager_id = m.emp_id
where e.emp_name = 'Toni Lembeck';
