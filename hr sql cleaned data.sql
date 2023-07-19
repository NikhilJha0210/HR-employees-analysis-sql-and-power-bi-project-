create database hr_project;
use hr_project;
show tables;
SELECT 
    *
FROM
    hr
LIMIT 10;
alter table hr 
change column ï»¿id emp_id varchar(30) null;
select * from hr;
describe hr;
select birthdate from hr;

set sql_safe_updates=0;
update hr
set birthdate=case
when birthdate like "%/%" then date_format(str_to_date(birthdate,"%m/%d/%Y"),"%Y-%m-%d")
when birthdate like "%-%" then date_format(str_to_date(birthdate,"%m-%d-%Y"),"%Y-%m-%d")
else null
end ;
alter table hr 
modify column birthdate date;
SELECT 
    birthdate
FROM
    hr;
describe hr;
update hr
set hire_date= case
when hire_date like "%/%" then date_format(str_to_date(hire_date,"%m/%d/%Y"),"%Y-%m-%d")
when hire_date like "%-%" then date_format(str_to_date(hire_date,"%m-%d-%Y"),"%Y-%m-%d")
else null 
end;
SELECT 
    hire_date
FROM
    hr;
alter table hr 
modify hire_date date ;
describe hr;

UPDATE hr 
SET 
    termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE
    termdate IS NOT NULL AND termdate != ' ';
SELECT 
    termdate
FROM
    hr; 
alter table hr
modify termdate date ;

describe hr;

alter table hr 
add column age int;

SELECT 
    *
FROM
    hr;

update hr
set age=timestampdiff(year,birthdate,curdate());

select age from hr ;
select min(age)as youngest,
max(age) as oldest from hr;

select count(*) as total_entries from hr;



-- now the cleanig process is done now we are going to analyse the dataset--
-- 1. what is the gender breakdown of company --
select gender from hr;
select count(gender) from hr where gender= "male";
select count(gender) from hr where gender ="female"; 