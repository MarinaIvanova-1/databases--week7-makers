require 'database_connection'
require 'post_repository'

def reset_posts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  describe "#post_with_comments(id)" do
    it "outputs a post with its comments by id" do
      repo = PostRepository.new

      post = repo.find_with_comments('1')

      expect(post.title).to eq "My first post"
      expect(post.content).to eq "My first content"

      expect(post.comments.length).to eq 2
      expect(post.comments.first.content).to eq "My first comment"
    end
  end
end





