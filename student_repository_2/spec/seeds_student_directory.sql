TRUNCATE TABLE cohorts, students RESTART IDENTITY; 

INSERT INTO cohorts (name, starting_date) VALUES ('April 2022', '2022, 04, 15');
INSERT INTO cohorts (name, starting_date) VALUES ('May 2022', '2022, 05, 15');

INSERT INTO students (name, cohort_id) VALUES ('David', '1');
INSERT INTO students (name, cohort_id) VALUES ('Mike', '2');
INSERT INTO students (name, cohort_id) VALUES ('Anna', '1');