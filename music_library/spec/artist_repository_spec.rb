require 'artist_repository'
require 'artist'

RSpec.describe ArtistRepository do
  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  describe ArtistRepository do
    before(:each) do 
      reset_artists_table
      reset_albums_table
    end

    it 'lists all artists in the repository' do
      repo = ArtistRepository.new

      artists = repo.all

      expect(artists.length).to eq  2
      expect(artists[0].id).to eq  '1'
      expect(artists[0].name).to eq 'Pixies'
      expect(artists[0].genre).to eq 'Rock'

      expect(artists[1].id).to eq '2'
      expect(artists[1].name).to eq 'ABBA'
      expect(artists[1].genre). to eq 'Pop'

    end

    it 'finds the artist with a given id' do
      repo = ArtistRepository.new

      artist = repo.find(1)

      expect(artist.id).to eq  '1'
      expect(artist.name).to eq 'Pixies'
      expect(artist.genre).to eq 'Rock'
    end

    it 'finds the artist with all its albums' do
      repo = ArtistRepository.new

      artist = repo.find_with_albums(1)
      expect(artist.name).to eq 'Pixies'
      expect(artist.genre).to eq 'Rock'
      expect(artist.albums.length).to eq 2
      expect(artist.albums.first.title).to eq 'Doolittle'
    end
  end
end