require_relative "../app"
require 'album_repository'
require 'artist_repository'

RSpec.describe AlbumRepository do
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

    it 'returns a list of all albums' do
      io = double(:io)
      expect(io).to receive(:puts).with("Welcome to the music library manager!")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with("1 - List all albums")
      expect(io).to receive(:puts).with("2 - List all artists")
      expect(io).to receive(:puts).with("Enter your choice:")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with("1 - Doolittle")
      expect(io).to receive(:puts).with("2 - Surfer Rosa")
      app = Application.new('music_library_test', io, AlbumRepository.new, ArtistRepository.new)
      app.run
    end

    it 'returns a list of all artists' do
      io = double(:io)
      expect(io).to receive(:puts).with("Welcome to the music library manager!")
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with("1 - List all albums")
      expect(io).to receive(:puts).with("2 - List all artists")
      expect(io).to receive(:puts).with("Enter your choice:")
      expect(io).to receive(:gets).and_return("2")
      expect(io).to receive(:puts).with("1 - Pixies")
      expect(io).to receive(:puts).with("2 - ABBA")
      app = Application.new('music_library_test', io, AlbumRepository.new, ArtistRepository.new)
      app.run
    end
  end
end