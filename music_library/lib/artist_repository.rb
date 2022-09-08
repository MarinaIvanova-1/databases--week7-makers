require_relative './database_connection'
require_relative './artist'

class ArtistRepository
  def all
    artists = []
    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']
      artists << artist
    end
    return artists
  end

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    sql_params = [id]
    record = DatabaseConnection.exec_params(sql,sql_params)
    artist = Artist.new
    artist.id = record[0]['id']
    artist.name = record[0]['name']
    artist.genre = record[0]['genre']
    return artist
    
  end

  def find_with_albums(id)
    sql = 'SELECT artists.id, artists.name, artists.genre, albums.id AS "album_id", albums.title
              FROM artists
              JOIN albums
              ON artists.id = albums.artist_id
              WHERE artists.id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])
    artist = Artist.new
    artist.id = result_set.first['id']   
    artist.name = result_set.first['name'] 
    artist.genre = result_set.first['genre'] 
    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      artist.albums << album
    end
    return artist
    # binding.irb 
  end
end