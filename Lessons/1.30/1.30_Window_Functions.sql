-- Count Rows - Aggregation Only
SELECT
    Count(*)
From job_postings_fact;

-- Count Rows - Windpw Function
SELECT 
    job_id,
    Count(*) Over ()
From job_postings_fact;

-- Partition By - Find hourly salary
SELECT 
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    avg(salary_hour_avg) Over (
        Partition By job_title_short, company_id
    )
From job_postings_fact
Where salary_hour_avg IS NOT NULL
Order BY Random()
LIMIT 10;

-- Order By - Ranking hourly salary
SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() Over (
        Order by salary_hour_avg DESC
    ) as rank_hourly_salary
From job_postings_fact
Where salary_hour_avg IS NOT NULL
Order BY salary_hour_avg DESC
LIMIT 10;

-- Partition by & Order by - Running Average houurly salary
SELECT 
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    avg(salary_hour_avg) Over (
        Partition By job_title_short
        Order by job_posted_date
    ) as running_avg_hourly_by_title
From job_postings_fact
Where salary_hour_avg IS NOT NULL and
job_title_short = 'Data Engineer'
Order BY job_title_short,
        job_posted_date
LIMIT 10;


-- Partition by & Order by job_title_shor
SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() Over (
        Partition by job_title_short
        Order by salary_hour_avg DESC
    ) as rank_hourly_salary
From job_postings_fact
Where salary_hour_avg IS NOT NULL
Order BY salary_hour_avg DESC,
        job_title_short
LIMIT 10;


-- Ranking Functions - Rank() VS Dense_Rank
SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    Dense_Rank() Over (
        Order by salary_hour_avg DESC
    ) as rank_hourly_salary
From job_postings_fact
Where salary_hour_avg IS NOT NULL
Order BY salary_hour_avg DESC
LIMIT 10;



-- Row_Number() - Providing a new job_id
SELECT *,
    Row_Number() over (
        order by job_posted_date
    )
From job_postings_fact
Order by job_posted_date
LIMIT 10;


-- Lag() - Time Based Comparison of Company Yearly Salary
SELECT
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    Lag(salary_year_avg) over (
        Partition by company_id
        Order by job_posted_date
    ) as previous_posting_salary,
    salary_year_avg - Lag(salary_year_avg) over (
        Partition by company_id
        Order by job_posted_date
    ) as salary_change,
From job_postings_fact
Where salary_year_avg IS NOT NULL
Order by company_id, job_posted_date
LIMIT 60;


SELECT
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    Lead(salary_year_avg) over (
        Partition by company_id
        Order by job_posted_date
    ) as next_posting_salary,
    salary_year_avg - Lead(salary_year_avg) over (
        Partition by company_id
        Order by job_posted_date
    ) as salary_change,
From job_postings_fact
Where salary_year_avg IS NOT NULL
Order by company_id, job_posted_date
LIMIT 60;