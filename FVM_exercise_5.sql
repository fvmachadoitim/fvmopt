-- 5. Create a new table that associates user to existing dept(s)

-- DROP TABLE dept_users;
CREATE TABLE dept_users
(
 dept number(4) not null,
 user_id number(4) not NULL,
 CONSTRAINT dept_users_pk PRIMARY KEY (dept, user_id)
);