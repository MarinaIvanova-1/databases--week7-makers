require 'post_repository'
require 'post'
require 'database_connection'

RSpec.describe PostRepository do
  def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_posts_tags_test' })
    connection.exec(seed_sql)
  end

  
  
  describe PostRepository do
    before(:each) do 
      reset_table
    end

    it "finds the post with its tags by its id" do
      repo = PostRepository.new
      posts = repo.find_by_tag('coding - test')

      expect(posts.length).to eq 4
      expect(posts.first.title).to eq ("How to use Git - test" )
      expect(posts.first.id).to eq '1'
      expect(posts[2].title).to eq ("Using IRB - test" )
      expect(posts[2].id).to eq '3'      
    end
  end
end