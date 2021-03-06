--Concatenation
select * from employees;
select First_name || ',' || last_name as full_name from employees; 

--Arithmetic
select salary, salary*12 as Annual_Salary from employees;
select sysdate+1 from dual;

--Operators
select * from employees where salary>1000;
select * from employees where salary<10000;
select * from employees where salary=9000;
select * from employees where salary<>9000;
select * from employees where salary!=9000;
select * from employees where manager_id is null;
select * from employees where salary between 1000 and 5000;
select * from employees where phone_number like '515%';
select * from employees where salary in (17000,24000);y

--Sorting
Select * from employees order by first_name asc;
Select * from employees order by first_name desc;

--nulls first and last
select * from employees order by manager_id nulls last;
select * from employees order by manager_id nulls last;

--RowNum(Changes), ROWID (Unique)
select first_name,last_name,Email,rownum,rowid from employees;

--List of first 10 employees who are in department 80
select * from employees where department_id=80 and rownum<10 order by employee_id asc;

--fetch from oracle 12g
select first_name,last_name,salary from employees FETCH FIRST 5 ROWS ONLY;

--substitution variable
select * from employees where department_id=&dept_no;

--conversion functions
select lower('rAvi gajul') from dual; --lower case
select upper('rAvi gajul') from dual; --uppper case
select initcap('rAvi gajul') from dual; ---camel case

--Numeric Functions
Select round(12.3456,2) from dual;
Select trunc(12.3456,2) from dual;
Select ceil(12.3456) from dual;
Select floor(12.3456) from dual;
select mod(4,3) from dual;

--Conditional Expressions
select employee_id,first_name,last_name,email,job_id,salary,
case job_id
    when 'IT_PROG' then salary*2
    When 'FI_MGR' then salary
    else salary 
    end as updated_Salary from employees;
    
--alternate syntax for case statement
select employee_id,first_name,last_name,email,job_id,salary,
case 
    when job_id='IT_PROG' then salary*2
    When job_id='FI_MGR' then salary
    else salary 
    end as updated_Salary from employees;
    
--searched Case expression in where clause
select * from employees 
where(CASE 
when job_id='IT_PROG' Then 1
when job_id='FI_MGR' then 1
else 0
end)=1;

--Decode is alternative to case.
select employee_id,first_name,last_name,email,job_id,salary,
DECODE( job_id,'IT_PROG',salary*2,
              'FI_MGR', salary) updated_Salary from employees;
              
              
---Rank() ..rank is not in sequence 
with temp_table as (select employee_id,first_name,last_name,salary,department_id, 
rank() over(PARTITION BY department_id ORDER BY salary DESC)as rank_sal from employees)
select * from temp_table where rank_sal=1;

---dense_Rank()...rank is in sequence
with temp_table as (select employee_id,first_name,last_name,salary,department_id, 
rank() over(PARTITION BY department_id ORDER BY salary DESC)as rank_sal from employees)
select * from temp_table where rank_sal=1;

--Case Conversion Functions
select lower('RAVI GAJUL') from dual;
select upper('ravi gajul') from dual;
select initcap('ravi GAJUL') from dual; --camel case
select first_name,upper(first_name),last_name,lower(last_name),email,initcap(email) from employees;

--Character Manipulation functions
select * from employees;
select SUBSTR('ABCDEFG',3,4) from dual;
select length('Ravi') from dual;
select CONCAT(CONCAT(last_name, '''s job category is '), job_id) from employees;
select First_name || ',' || last_name as full_name from employees; 
--instr
select instr('ravi ravi','i',1,2) from dual; --character to search for, start searching from index, which occurence
select instr('ravi ravi','i',-1,2) from dual; --start searching form the right to left, however position is calculated right to left
select first_name,instr(first_name,'a') from employees; --case sensitive so in Adam it returns 3 and not one.
--trim
select trim(' My name is ravi ') as name from dual; --removes only leading and trailing spaces and not in between
select trim(leading ' ' from ' My name is ravi   ')as name from dual; --removes leading spaces
select trim(trailing ' ' from ' My name is ravi ')as name from dual; --removes trailing spaces
select trim(both ' ' from '   my name is ravi  ' ) as name from dual; --alternative to trim
select trim(leading 'my' from 'my name is ravi  ') as name from dual; --trim cannot have more than one character 

--ltrim
select ltrim('   My name is ravi   ') as name from dual; ---alternative to leading
select ltrim('My name is ravi   ','My') as name from dual; --can have more than one string for replacing

--rtrim
select rtrim('   My name is ravi   ') as name from dual; ---alternative to trailing
select rtrim('My name is raviMy','My') as name from dual; --trim happens for all characters doesn't need to be same order see below
select rtrim('My name is raviMy','yM') as name from dual;
select rtrim('My name is raviMmmmmmmmy','ymM') as name from dual;

--nested function
select rtrim(ltrim('www.mydomainname.com','w.'),'.com') from dual;

--Replace
select REPLACE('JACK and JUE','J','BL') as Replaced_String from dual; --expect an exact match unlike trim

--LPAD
select LPAD('123',6,'0') from dual;

--RPAD
select RPAD('123',6,'0') from dual;

--soundex --similar sound 
select * from employees where soundex(first_name)=soundex('steven');

--Translate --replace A with B and B with C and A with a and so on.
select translate('interface', 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqr\stuvwxyx','BCDEFGHIJKLMNOPQRSTUVWXYZAbcdefghijklmnopqrstuvwxyza')
trans from dual;

--Numeric Functions
select trunc(12.3456,2),round(12.3456,2),ceil(12.3456),floor(12.34) from dual;

--Nested Functions ---to extract last name
select SUBSTR('Ravi Gajul',instr('Ravi Gajul',' ',1)+1,length('Ravi Gajul')) as name from dual;
select SUBSTR('Ravi Gajul',instr('Ravi Gajul',' ',1)+1) as name from dual; --since the last parameter in substr is optional

--Date Functions
select sysdate from dual;
select current_Date from dual;
select SESSIONTIMEZONE, CURRENT_DATE FROM DUAL;
select systimestamp from dual;
select current_timestamp from dual;

--Date Operations
select sysdate,sysdate+2 from dual;
select sysdate,sysdate+1/24 from dual;

--date manipulation functions
select sysdate,add_months(sysdate,2) from dual;
select trunc(MONTHS_BETWEEN(SYSDATE,hire_date)) from employees;
select round(sysdate,'MONTH') from dual; --->15 first of next month
select round(sysdate,'YEAR') from dual;  -- >July
select trunc(sysdate,'MONTH') from dual;
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual;
select extract(year from sysdate) from dual;
select next_Day(sysdate,'TUESDAY') from dual;
select last_day(sysdate) from dual;

--implicit conversion functions
select employee_id || first_name from employees; --number to varchar2
select first_name || hire_date from employees;   ---date to varchar2
select * from employees where hire_date='17-JUN-03'; --varchar2 to date
select * from employees where employee_id='100'; --varchar2 to number

--explicit conversion functions
select to_char(hire_date,'YYYY') from employees;
select to_char(hire_date,'YEAR') from employees;
select to_char(hire_date,'DD-MM-YYYY') from employees;
select to_char(hire_date,'DD-MON-YYYY'),to_char(hire_date,'dd-mon-yyyy'),to_char(hire_date,'dd-Mon-yyyy')from employees;
select to_char(hire_date,'DD') from employees; --day of the month
select to_char(hire_date,'DDD') from employees; --day of the year
select to_char(hire_date,'DAY') from employees;

--to_date
select to_date('17-Jun-2020','DD-MM-YY') from dual;
select to_date('2020-Jun-15','YY-MM-DD') from dual;
select to_date('2020-Jun-15','YYYY/MON/DD') from dual;
 
--Number Format models
SELECT salary,TO_CHAR(salary,'$99,999.99') from employees;
SELECT salary,TO_CHAR(salary,'L99,999.99') from employees; --depends on the country will see $ or euro symbol
SELECT salary,TO_CHAR(salary,'$09,999.99') from employees; --lpad zero

--to_number

select to_number('$12,345.98','$99,999.99') from dual;

--null value functions
select manager_id,nvl(manager_id,0) from employees; --data types should match for both expressions
select salary,salary+salary*nvl(commission_pct,0),nvl(commission_pct,0) from employees;

--nvl2
select nvl2(null,'1','0') from dual; --if not null return exp2 else return exp1
select nvl2('1','2','3') from dual;
select commission_pct,nvl2(commission_pct,'has commission','no commission') from employees;

--nullif
select nullif(1,1) from dual; --return null if exp1 and exp2 are equal else return exp1
select nullif(1,2) from dual; --return exp1 if exp1 and exp2 are not equal.

--coalesce (improved version of nvl).Accepts the list of expressions and returns the first one that evaluated to not null
select coalesce(commission_pct,manager_id,department_id) from employees;
select * from employees where manager_id is null;

--Group functions .All group functions ignore the null values
select avg(salary) from employees;
select max(salary) from employees;
select min(salary) from employees;
select sum(salary) from employees;
select count(salary) from employees;
select LISTAGG(last_name, '; ') WITHIN GROUP (ORDER BY hire_date desc) "lastnames" from employees;
select * from employees order by hire_date desc;

--grouping functions
select department_id,round(avg(salary)) from employees group by department_id order by department_id asc;
select department_id,count(*) from employees group by department_id having count(*)>5 order by count(*) desc;

--grouping ...numnber of employees joined by year and month
select extract(year from hire_Date) year,extract(month from hire_Date) month,count(*) cnt from employees group by extract(year from hire_date),extract(month from hire_Date) 
order by year,month;

--REGEXP_LIKE --first name starting and ending with vowels
select distinct first_name from employees where REGEXP_LIKE(LOWER(first_name), '^[aeiou].*[aeiou]$');
--first name starting with vowels using substring
select distinct first_name from employees where SUBSTR(first_name,1,1) in ('A','E','I','O','U');

--first name not starting with vowel
select distinct first_name from employees where  REGEXP_LIKE(LOWER(first_name), '^[^aeiou].*');

--Query the Name of any student in STUDENTS who scored higher than  Marks.
--Order your output by the last three characters of each name. 
--If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), 
--secondary sort them by ascending ID.
select  name from students where marks>75 order by substr(name,-3),id asc;

--Single Row SubQueries
--Find all employees who joined after Neena
select * from employees where hire_date > (select hire_date from employees where employee_id=101);

--Find all employees whose salary is greater than Neena
select * from employees where salary > (select salary from employees where employee_id=101);

--Find all employees who work in same department as that of Neena

select * from employees where department_id = (select department_id from employees where employee_id=101);

--Find all employees who work in same department as that of Neena and earn more than Neena
select * from employees where department_id = (select department_id from employees where employee_id=101)
and salary > (select salary from employees where employee_id=101);

--Find the employee who was hired first
select * from employees where hire_date = (select min(hire_date) from employees);

--Find the employee who was hired recently
select * from employees where hire_date = (select max(hire_date) from employees);

--Multiple Row Functions
--find the employees with min salary in each department
select * from employees where salary in (
select min(salary) from employees group by department_id);

--find the employees whose salary is more than any of the sales managers
select * from employees where salary > ANY (select salary from employees where job_id='SA_MAN');
--find the employees whose salary is less than all of the sales managers
select * from employees where salary < ALL (select salary from employees where job_id='SA_MAN');

--Multiple column sub queries
---non pair wise comparison subquery
select * from employees 
where 
department_id in 
    (select department_id from employees where department_id in (110,80,70))
and salary in 
(select salary from employees where department_id in(110,80,70));

--Pair wise comparison subquery
select * from employees 
where (department_id,salary) in 
    (select department_id,salary from employees where department_id in (110,80,70));
