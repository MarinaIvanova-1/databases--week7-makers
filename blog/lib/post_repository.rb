require 'database_connection'
require 'posts'
require 'comments'

class PostRepository

  # takes one argument - post id
  def find_with_comments(id)
    # Runs sql query
    sql = 'SELECT posts.id AS "post_id", posts.title, posts.content AS "post_content", 
          comments.id AS "comment_id", comments.content AS "comment_content",  comments.author
          FROM posts
          JOIN comments ON posts.id = comments.post_id
          WHERE posts.id = $1;'
    sql_params = [id]
    
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    post = Post.new
    post_record = result_set.first
    post.title = post_record['title']
    post.content = post_record['post_content']
    
    result_set.each do |record|
      comment = Comment.new
      comment.id = record['comment_id']
      comment.content = record['comment_content']
      comment.author = record['author']
      comment.post_id = record['post_id']
      post.comments << comment
    end
    
    # returns a single post object with its comments
    return post
    end
end