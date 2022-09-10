require 'tag_repostitory'
require 'tag'
require 'database_connection'

RSpec.describe TagRepository do
  def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_posts_tags_test' })
    connection.exec(seed_sql)
  end

  
  
  describe TagRepository do
    before(:each) do 
      reset_table
    end

    it "prints the " do
      repo = TagRepository.new
      tags = repo.find_by_post('Ruby classes - test')

      expect(tags.length).to eq 2
      expect(tags.first.name).to eq ("coding - test" )
      expect(tags.first.id).to eq '1'
      expect(tags[1].name).to eq ("ruby - test" )
      expect(tags[1].id).to eq '4' 

    end
  end
end