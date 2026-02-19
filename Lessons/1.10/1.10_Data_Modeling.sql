SELECT 
    *
FROM company_dim
LIMIT 10;

SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    company_id
FROM job_postings_fact
LIMIt 10;

SELECT *
FROM skills_job_dim
LIMIT 5;


SELECT *
FROM skills_dim
LIMIT 5;

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'data_jobs';


SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_catalog = 'data_jobs';



SELECT *
FROM information_schema.table_constraints
WHERE table_catalog = 'data_jobs';


PRAGMA SHOW_tables;


PRAGMA SHOW_tables_expanded;

DESCRIBE job_postings_fact;