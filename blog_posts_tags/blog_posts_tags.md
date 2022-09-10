# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: posts

Columns:
id | title 

Table: tags

Columns:
id | name 

Table: posts_tags

Columns:
post_id | tag_id 
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE posts, posts_tags, tags RESTART IDENTITY;

INSERT INTO "public"."posts" ("id", "title") VALUES
(1, 'How to use Git - test'),
(2, 'Ruby classes - test'),
(3, 'Using IRB - test'),
(4, 'My weekend in Edinburgh - test'),
(5, 'The best chocolate cake EVER - test'),
(6, 'A foodie week in Spain - test'),
(7, 'SQL basics - test');

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

INSERT INTO "public"."tags" ("id", "name") VALUES
(1, 'coding - test'),
(2, 'travel - test'),
(3, 'cooking - test'),
(4, 'ruby - test');

ALTER TABLE "public"."posts_tags" ADD FOREIGN KEY ("tag_id") REFERENCES "public"."tags"("id");
ALTER TABLE "public"."posts_tags" ADD FOREIGN KEY ("post_id") REFERENCES "public"."posts"("id");

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 blog_posts_tags_test < seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end

# Table name: tags

# Model class
# (in lib/tag.rb)
class Tag
end

# Repository class
# (in lib/tag_repository.rb)
class TagRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :tags
end

# Table name: tags

# Model class
# (in lib/tag.rb)

class Tag

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :posts
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Gets an array of posts associated with a given tag
  # One argument: tag name
  def find_by_tag(name)
    # Executes the SQL query:
    #  SELECT posts.id AS "post_id", posts.title, tags.name as "tag_name"
    #      FROM posts
    #      JOIN posts_tags ON posts.id = posts_tags.post_id
    #      JOIN tags ON tags.id = posts_tags.tag_id
    #      WHERE tags.name = $1;

    # Returns an array of Post objects with a given tag
  end

end


class TagRepository

  # Gets an array of tags associated with a given post
  # One argument: post name
  def find_by_post(post)
    # Executes the SQL query:
    # SELECT tags.id AS "tag_id", tags.name, posts.title AS "post_title"
    #   FROM tags
    #   JOIN posts_tags ON tags.id = posts_tags.tag_id
    #   JOIN posts ON posts.id = posts_tags.post_id
    #   WHERE posts.title = $1;

    # Returns an array of Tag objects from a given post
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get posts associated with a given tag

repo = PostRepository.new
posts = repo.find_by_tag('coding - test')

expect(posts.length).to eq 4
expect(posts.first.title).to eq ("How to use Git - test" )
expect(posts.first.id).to eq '1'
expect(posts[2].title).to eq ("Using IRB - test" )
expect(posts[2].id).to eq '3'   



# 2
# Get tags associated with a given post

repo = TagRepository.new
tags = repo.find_by_post('Ruby classes - test')

expect(tags.length).to eq 2
expect(tags.first.name).to eq ("coding - test" )
expect(tags.first.id).to eq '1'
expect(tags[1].name).to eq ("ruby - test" )
expect(tags[1].id).to eq '2'  

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/post_repository_spec.rb

def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_posts_tags_test' })
    connection.exec(seed_sql)
  end

  describe PostRepository do
    before(:each) do 
      reset_table
    end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._