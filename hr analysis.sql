-- now the cleanig process is done now we are going to analyse the dataset--
-- 1. what is the gender breakdown of company --
select gender from hr;

SELECT 
    gender, COUNT(*) AS total
FROM
    hr
WHERE
    age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;

-- 2 what is the race / etnicity breakdown of employees in the company--
select * from hr;
SELECT 
    race, COUNT(*) AS total
FROM
    hr
WHERE
    age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY total DESC; 

-- 3 what is the age distribution the company--
SELECT 
    MIN(age) AS youngest_person, MAX(age) AS oldest_person
FROM
    hr
WHERE
    age >= 18 AND termdate = '0000-00-00'; 


SELECT 
    CASE
        WHEN age >= 18 AND age <= 25 THEN '18-25'
        WHEN age >= 26 AND age <= 32 THEN '26-32'
        WHEN age >= 33 AND age <= 40 THEN '33-40'
        WHEN age >= 41 AND age <= 50 THEN '41-50'
        WHEN age >= 51 AND age <= 60 THEN '51-60'
        ELSE 'greater than 60'
    END AS age_group,gender,
    COUNT(*) AS total_employees
FROM
    hr
WHERE
    age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group,gender 
ORDER BY age_group,gender;


-- 4 how many employees work at headquaters versus remote locations ?

select location from hr;

SELECT 
    location, COUNT(*) AS total_employees
FROM
    hr
WHERE
    age >= 18 AND termdate = '0000-00-00'
GROUP BY location
ORDER BY total_employees;

-- what is the average length of employment for empluees who have terminated?--
SELECT 
    ROUND(AVG(DATEDIFF(termdate, hire_date)) / 365) AS avg_work_year
FROM
    hr
WHERE
    age >= 18 AND termdate <= CURDATE()
        AND termdate <> '0000-00-00'; 


--  6 how does the gender distribution vary across departments and job titles?

SELECT 
    gender, department, jobtitle, COUNT(*) AS total_employees
FROM
    hr
WHERE
    age >= 18 AND termdate = '0000-00-00'
GROUP BY gender , department
ORDER BY department;

-- 7 what is the distribution of job titles accross the company 
SELECT 
    jobtitle, COUNT(*) as total_employees
FROM
    hr
WHERE
    age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle;

-- 8 which department has the highesr turnover rate ?
SELECT 
    department,
    total_count,
    termination_count,
    termination_count / total_count AS termination_rate
FROM
    (SELECT 
        department,
            COUNT(*) AS total_count,
            SUM(CASE
                WHEN
                    termdate != '0000-00-00'
                        AND termdate < CURDATE()
                THEN
                    1
                ELSE 0
            END) AS termination_count
    FROM
        hr
    WHERE
        age >= 18
    GROUP BY department) AS subquery
ORDER BY termination_count DESC;

-- 9 what is distribution of employees across location by city and state?
select location_state  ,  count(*) as total_employees from hr where age>=18 and termdate="0000-00-00" group by location_state order by location_state;

select location_city  ,  count(*) as total_employees from hr where age>=18 and termdate="0000-00-00" group by location_city order by location_city;


-- 10 what is the tenure distribution of each department ?
SELECT 
    department,
    ROUND(AVG(DATEDIFF(termdate, hire_date) / 365),
            0) AS avg_tenure
FROM
    hr
WHERE
    termdate <= CURDATE() AND age >= 18
        AND termdate != '0000-00-00'
GROUP BY department;
