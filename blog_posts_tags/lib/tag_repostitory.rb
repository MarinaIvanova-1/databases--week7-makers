require_relative './tag'
require_relative './database_connection'

class TagRepository
  def find_by_post(name)
    sql = 'SELECT tags.id AS "tag_id", tags.name, posts.title AS "post_title"
              FROM tags
              JOIN posts_tags ON tags.id = posts_tags.tag_id
              JOIN posts ON posts.id = posts_tags.post_id
              WHERE posts.title = $1;'
    sql_param = [name]

    result_set = DatabaseConnection.exec_params(sql,sql_param)

    tags = []
    result_set.each do |record|
      tag = Tag.new
      tag.id = record['tag_id']
      tag.name = record['name']
      tags << tag
    end
    return tags 
  end
end