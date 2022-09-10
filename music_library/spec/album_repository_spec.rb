require 'album_repository'
require 'album'

RSpec.describe AlbumRepository do
  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  
  
  describe AlbumRepository do
    before(:each) do 
      reset_albums_table
    end
  
    it 'returns the list of all albums' do
      repo = AlbumRepository.new

      albums = repo.all

      expect(albums.length).to eq 2

      expect(albums.first.id).to eq '1'
      expect(albums.first.title).to eq 'Doolittle'
      expect(albums[0].release_year).to eq '1989'

    end

    it 'finds an album eith a given id' do
      repo = AlbumRepository.new

      album1 = repo.find(1)

      expect(album1.title).to eq 'Doolittle'
      expect(album1.release_year).to eq '1989'
      expect(album1.artist_id).to eq '1'
      
      album2 = repo.find(2)
      expect(album2.title).to eq 'Surfer Rosa'
      expect(album2.release_year).to eq '1988'
      expect(album2.artist_id).to eq '1'
    end

    it 'creates a new album in the database' do
      repo = AlbumRepository.new

      album = Album.new
      album.title = "OK computer"
      album.release_year = 2005
      album.artist_id = 1

      repo.create(album)

      expect(repo.all.last.title).to eq 'OK computer'
      expect(repo.all.last.release_year).to eq '2005'
      expect(repo.all.last.artist_id).to eq '1'
    end

    it 'deletes an album with a given id' do
      repo = AlbumRepository.new
      repo.delete(1)

      album = repo.all.first

      expect(repo.all.length).to eq 1
      expect(album.id).to eq '2'
      expect(album.title).to eq 'Surfer Rosa'
      expect(album.release_year).to eq '1988'
    end

    it 'updates the record with given information' do
      repo = AlbumRepository.new
      album = repo.find(1)
      album.title = 'Whatever'
      repo.update(album)
      album_updated = repo.find(1)
      expect(album_updated.title).to eq 'Whatever'
    end
  end
end


