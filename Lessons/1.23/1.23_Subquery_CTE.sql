-- Subquery_CTE
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    OR salary_hour_avg IS NOT NULL
) as valid_salaries
LIMIT 10;

-- CTE
With valid_salaries as (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    OR salary_hour_avg IS NOT NULL
)
SELECT *
FROM valid_salaries;

-- Scenario 1 - Subquery in `SELECT`
-- Show each job's salary next to the overall market median:
SELECT 
    job_title_short,
    salary_year_avg,
    (
        SELECT median(salary_year_avg)
        From job_postings_fact
    ) as market_median_salary
From job_postings_fact
WHERE salary_year_avg is not null
LIMIT 10;

-- Scenario 2 - Subquery in From
-- Stage only jobs that are remote before aggregating to determine the remote median salary per job
SELECT 
    job_title_short,
    median(salary_year_avg) as median_salary,
    (
        SELECT median(salary_year_avg)
        From job_postings_fact
        where job_work_from_home = TRUE
    ) as market_remote_median_salary
    FROM (
        SELECT
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    Where job_work_from_home = TRUE
    ) as clean_jobs
WHERE salary_year_avg is not null
Group by job_title_short
LIMIT 10;


-- Scenario 3 -- Subquery in Having
-- Keep only job titles whose median salary is above the overall median:
SELECT 
    job_title_short,
    median(salary_year_avg) as median_salary,
    (
        SELECT median(salary_year_avg)
        From job_postings_fact
        where job_work_from_home = TRUE
    ) as market_remote_median_salary
    FROM (
        SELECT
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    Where job_work_from_home = TRUE
    ) as clean_jobs
WHERE salary_year_avg is not null
Group by job_title_short
HAVING median(salary_year_avg) > (
   SELECT median(salary_year_avg)
        From job_postings_fact
        where job_work_from_home = TRUE 
)
LIMIT 10;


-- CTE Example
-- Compare how much (or less) remote roles pay compared to onsite roles for each job title.
-- Use a CTE to calculate the median salary by title and work arrangement, then compare those medians.
 With title_median as (
    SELECT
        job_title_short,
        job_work_from_home,
        median(salary_year_avg)::INT as median_salary
    From job_postings_fact
    WHERE job_country = 'United States'
    Group by job_title_short,
            job_work_from_home

 )
 SELECT
    r.job_title_short,
    r.median_salary as remote_median_salary,
    o.median_salary as onsite_median_salary,
    (r.median_salary - o.median_salary) as remote_premium
From title_median as r
INNER JOIN title_median as o
ON   r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE
AND o.job_work_from_home = FALSE
Order by remote_premium DESC;


-- Final Example
-- Identify job postings that have no associated skills before loading them into a data mart
SELECT *
From job_postings_fact
Order by job_id
LIMIT 10;

SELECT *
FROM skills_job_dim
Order by job_id
LIMIT 40;

SELECT *
FROM job_postings_fact as tgt
Where NOT EXISTS (
    SELECT 1
    FROM skills_job_dim as src
    WHERE tgt.job_id = src.job_id

)
Order by job_id;