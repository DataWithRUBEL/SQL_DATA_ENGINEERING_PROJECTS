SELECT Length('SQL');

SELECT UPPER('sql');
SELECT LOWER('SQL');

SELECT LEFT('SQL', 2);
SELECT RIGHT('SQL', 2);
SELECT SUBSTRING('SQL', 2);

SELECT CONCAT('SQL', '-', 'Functions');
SELECT ('SQL'|| '-' || 'Functions');


-- Final Example - Simplify with Coalesce


    SELECT 
        job_title_short,
        salary_year_avg,
        salary_hour_avg,
        Coalesce(salary_hour_avg, salary_hour_avg * 2080) AS standardized_salary,
        CASE 
            WHEN Coalesce(salary_hour_avg, salary_hour_avg * 2080) IS NULL Then 'Missing'
            WHEN Coalesce(salary_hour_avg, salary_hour_avg * 2080) < 75000 THEN  'Low'
            WHEN Coalesce(salary_hour_avg, salary_hour_avg * 2080) < 150000 Then 'Mid'
            ELSE 'High'
            END AS salary_bucket
        FROM job_postings_fact
        ORDER BY standardized_salary Desc;


        
