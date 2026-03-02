-- Step 3: Create priority jobs snapshot table
-- This table contains a snapshot of jobs with their priority levels
CREATE TABLE priority_mart.priority_jobs_snapshot (  -- updated to use priority_mart schema
  job_id              INTEGER PRIMARY KEY,
  job_title_short     VARCHAR,
  company_name        VARCHAR,
  job_posted_date     TIMESTAMP,
  salary_year_avg     DOUBLE,
  priority_lvl        INTEGER,
  updated_at          TIMESTAMP
);

INSERT INTO priority_mart.priority_jobs_snapshot (   -- updated to use priority_mart schema
  job_id,
  job_title_short,
  company_name,
  job_posted_date,
  salary_year_avg,
  priority_lvl,
  updated_at
)
SELECT 
  jpf.job_id,
  jpf.job_title_short,
  cd.name AS company_name,
  jpf.job_posted_date,
  jpf.salary_year_avg,
  r.priority_lvl,
  CURRENT_TIMESTAMP
FROM
    data_jobs.job_postings_fact AS jpf             -- updated to use main schema
LEFT JOIN data_jobs.company_dim AS cd              -- updated to use main schema
    ON jpf.company_id = cd.company_id
INNER JOIN jobs_mart.staging.priority_roles AS r  -- updated to use priority_mart schema
    ON jpf.job_title_short = r.role_name;

SELECT 
    job_title_short,
    COUNT(*) AS job_count,
    MIN(priority_lvl) AS priority_lvl,
    MIN(updated_at) AS updated_at
FROM priority_mart.priority_jobs_snapshot          -- updated to use priority_mart schema
GROUP BY job_title_short
ORDER BY job_count DESC;