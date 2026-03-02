SELECT Unnest([1,1,1,2])
UNION
SELECT Unnest([1,1,3]);

SELECT Unnest([1,1,1,2])
UNION ALL
SELECT Unnest([1,1,3]);

SELECT Unnest([1,1,1,2])
INTERSECT
SELECT Unnest([1,1,3]);

SELECT Unnest([1,1,1,2])
INTERSECT ALL
SELECT Unnest([1,1,3]);

SELECT Unnest([1,1,1,2])
EXCEPT ALL
SELECT Unnest([1,1,3]);


-- inspect the real column names
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'job_postings_fact';

-- …or just dump one row
SELECT *
FROM job_postings_fact
LIMIT 1;

CREATE TEMP TABLE jobs_2023 AS 
SELECT * EXCLUDE (job_id, job_posted_date)        
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

SELECT * From jobs_2024;


SELECT *
FROM job_postings_fact
LIMIT 1;

CREATE TEMP TABLE jobs_2024 AS 
SELECT * EXCLUDE (job_id, job_posted_date)       
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;  



-- Which unique job postings appeared in either 2023 or 2024?

SELECT * From jobs_2023
UNION
SELECT * From jobs_2024;


SELECT * From jobs_2023
UNION ALL
SELECT * From jobs_2024;


SELECT * From jobs_2023
EXCEPT ALL
SELECT * From jobs_2024;


SELECT * From jobs_2023
INTERSECT
SELECT * From jobs_2024;

SELECT * From jobs_2023
INTERSECT ALL
SELECT * From jobs_2024;
