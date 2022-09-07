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
end