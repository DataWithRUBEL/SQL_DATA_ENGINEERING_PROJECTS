-- Array Intro
SELECT [1,2,3];
SELECT ['python', 'sql', 'r'] AS skills_array;

-- Struct
SELECT { skill: 'python', type: 'programming'} as skill_struct;

-- MAP
With skill_map AS (
SELECT MAP {'skill': 'python', 'type': 'programmimg'} AS skill_type
)
SELECT 
    skill_type['skill'],
    skill_type['type']
From skill_map;

-- JSON
With raw_skill_json as (
SELECT
    '{"skill":"python", "type":"programming"}'::JSON as skill_json
)
SELECT
    Struct_Pack(
        skill := json_extract_string(skill_json, '$.skill'),
        type := json_extract_string(skill_json, '$.type')
    )
From raw_skill_json;


-- Arrays - Final Example
-- Build a flat skill table for co-workers to access job titles, salary info, and skills in one table
Create Or Replace TEMP Table job_skills_arry_struct as
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    Array_AGG(
        Struct_Pack(
            skill_type := sd.type,
            skill_name := sd.skills
        )
    ) as skills_type
From job_postings_fact as jpf
Left join skills_job_dim as sjd
On jpf.job_id = sjd.job_id
Left Join skills_dim as sd
On sd.skill_id = sjd.skill_id
Group by all;

SELECT 
    job_id,
    job_title_short,
    salary_year_avg,
    Unnest(skills_type).skill_type as skill_type,
    Unnest(skills_type).skill_name as skill_name
From job_skills_arry_struct;