TRUNCATE TABLE posts, posts_tags, tags RESTART IDENTITY;

INSERT INTO "public"."posts" ("title") VALUES
('How to use Git - test'),
('Ruby classes - test'),
('Using IRB - test'),
('My weekend in Edinburgh - test'),
('The best chocolate cake EVER - test'),
('A foodie week in Spain - test'),
('SQL basics - test'),
('SQL basics3 - test');;

INSERT INTO "public"."tags" ("name") VALUES
('coding - test'),
('travel - test'),
('cooking - test'),
('ruby - test');

INSERT INTO "public"."posts_tags" ("post_id", "tag_id") VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 3),
(6, 2),
(7, 1),
(6, 3),
(2, 4),
(3, 4);

ALTER TABLE "public"."posts_tags" ADD FOREIGN KEY ("tag_id") REFERENCES "public"."tags"("id");
ALTER TABLE "public"."posts_tags" ADD FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id");
