TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, cooking_time, rating) VALUES ('Sandwich', '10', '3');
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Stew', '90', '5');
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Soup', '30', '5');