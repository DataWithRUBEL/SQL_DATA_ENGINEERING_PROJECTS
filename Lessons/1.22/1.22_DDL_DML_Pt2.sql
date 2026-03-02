
CREATE TABLE staging.job_postings_flat AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name  as company_name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
ON jpf.company_id = cd.company_id;

SELECT *
From staging.job_postings_flat
Limit 10;

SELECT Count(*)
FROM staging.job_postings_flat;

CREATE VIEW staging.priority_jobs_flat_view as
SELECT 
    jpf.*
FROM staging.job_postings_flat as jpf
JOIN staging.priority_roles as r
ON jpf.job_title_short = r.role_name
WHERE r.priority_lvl = 1;


SELECT Count(*)
FROM staging.priority_jobs_flat_view;

SELECT 
    job_title_short,
    Count(*) as job_count
From staging.priority_jobs_flat_view
GRoup by job_title_short
Order by job_count DESC;

CREATE TEMPORARY TABLE senior_jobs_flat_temp as
SELECT *
From staging.priority_jobs_flat_view
WHERE job_title_short = 'Senior Data engineer';

SELECT 
    job_title_short,
    Count(*) as job_count
From senior_jobs_flat_temp
GRoup by job_title_short
Order by job_count DESC;


SELECT COUNT(*) from staging.job_postings_flat;
SELECT COUNT(*) from staging.priority_jobs_flat_view;
SELECT COUNT(*) from senior_jobs_flat_temp;