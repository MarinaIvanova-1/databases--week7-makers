require_relative './post'
require_relative './database_connection'
require_relative './tag'

class PostRepository
  def find_by_tag(name)

    sql = 'SELECT posts.id AS "post_id", posts.title, tags.name as "tag_name"
            FROM posts
            JOIN posts_tags ON posts.id = posts_tags.post_id
            JOIN tags ON tags.id = posts_tags.tag_id
            WHERE tags.name = $1;'

    sql_param = [name]

    result_set = DatabaseConnection.exec_params(sql, sql_param)
    posts = []
    result_set.each do |record|
      post = Post.new
      post.id = record['post_id']
      post.title = record['title']
      posts << post
    end
    return posts
  end

end