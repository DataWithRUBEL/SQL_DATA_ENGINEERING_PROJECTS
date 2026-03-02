-- .read Lessons\1.21\1.21_DDL_DML_Pt1.sql

use data_jobs;

CREATE DATABASE IF NOT EXISTS jobs_mart;


Show DATABASES;

 DROP DATABASE IF EXISTS jobs_mart;


SELECT *
FROM information_schema.schema

CREATE SCHEMA  staging;

-- DROP SCHEMA staging;

CREATE TABLE staging.preferred_roles (
    role_id INT,
    role_name VARCHAR
);

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';



INSERT INTO jobs_mart.staging.preferred_roles (role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer '),
    (3, 'Software Engineer');

SELECT *
FROM jobs_mart.staging.preferred_roles;


ALTER TABLE jobs_mart.staging.preferred_roles
DROP COLUMN preferred_role Boolean;


UPDATE jobs_mart.staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id = 1 or role_id = 2;


UPDATE jobs_mart.staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

ALTER TABLE jobs_mart.staging.preferred_roles
RENAME TO priority_roles;

SELECT *
FROM jobs_mart.staging.priority_roles;

ALTER TABLE jobs_mart.staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;


ALTER TABLE jobs_mart.staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

UPDATE jobs_mart.staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;



