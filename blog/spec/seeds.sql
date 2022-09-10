TRUNCATE TABLE comments, posts RESTART IDENTITY;

INSERT INTO posts (title, content) VALUES ('My first post', 'My first content');
INSERT INTO posts (title, content) VALUES ('My second post', 'My second content');

INSERT INTO comments (content, author, post_id) VALUES ('My first comment', 'Mark', '1');
INSERT INTO comments (content, author, post_id) VALUES ('My second comment', 'Jane', '2');
INSERT INTO comments (content, author, post_id) VALUES ('My third comment', 'Chris', '1');