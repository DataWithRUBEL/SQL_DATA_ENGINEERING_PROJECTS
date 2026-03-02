CREATE TABLE staging.priority_roles (                          -- updated to use priority_mart schema & remove 'OR REPLACE'
  role_id      INTEGER PRIMARY KEY,
  role_name    VARCHAR,
  priority_lvl INTEGER
);

INSERT INTO jobs_mart.staging.priority_roles (role_id, role_name, priority_lvl)        -- updated to use priority_mart schema
VALUES
  (1, 'Data Engineer',       2),
  (2, 'Senior Data Engineer', 1),
  (3, 'Software Engineer',   4);

  SELECT *
  From jobs_mart.staging.priority_roles;