SELECT 
    job_posted_date,
    job_posted_date::Date AS date,
    job_posted_date::Time AS time,
    job_posted_date::Timestamp AS timestamp,
    job_posted_date::Timestamptz AS timeestampz
FROM job_postings_fact
LIMIT 10;



SELECT 
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
   COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY EXTRACT(YEAR FROM job_posted_date),
         EXTRACT(MONTH FROM job_posted_date)
ORDER BY job_posted_year,
         job_posted_month;


SELECT 
    job_posted_date,
    DATE_TRUNC('month', job_posted_date) AS job_posted_month
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 10;
