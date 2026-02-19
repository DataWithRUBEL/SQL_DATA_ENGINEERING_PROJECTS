/*
Find the top 10 companies for posting jobs
They must have >3000 posting
Limit this to only US jobs
*/

SELECT
    cd.name as company_name,
    COUNT(jpf.*) as posting_count
FROM job_postings_fact as jpf
LEFT JOIN company_dim as cd
On jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name;



EXPLAIN ANALYZE
SELECT
    cd.name as company_name,
    COUNT(jpf.job_id) as posting_count
FROM job_postings_fact as jpf
LEFT JOIN company_dim as cd
On jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id) > 3000
Order by posting_count DESC
LIMIT 10;
