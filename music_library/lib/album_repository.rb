require_relative './database_connection'
require_relative './album'

class AlbumRepository
  def initialize
  end

  def all
    result_set = DatabaseConnection.exec_params('SELECT * FROM albums;', [])

    albums = []
    result_set.each do |record|
      album = Album.new
      album.id = record["id"]
      album.title = record["title"]
      album.release_year = record["release_year"]
      albums << album
    end
    return albums
  end

  def find(id)
    sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    sql_param = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_param)
    album = Album.new
    album.id = result_set[0]["id"]
    album.title = result_set[0]["title"]
    album.release_year = result_set[0]["release_year"]
    album.artist_id = result_set[0]['artist_id']
    return album
  end

end