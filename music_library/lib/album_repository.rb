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
      album.artist_id = record["artist_id"]
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

  def create(album)
    sql = "INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);"
    sql_param = [album.title, album.release_year, album.artist_id]
    DatabaseConnection.exec_params(sql, sql_param)
  end

  def delete(id)
    sql = "DELETE FROM albums WHERE id = $1;"
    sql_param = [id]
    DatabaseConnection.exec_params(sql, sql_param)

  end

  def update(album)
    sql = "UPDATE albums SET title = $1, release_year = $2, artist_id = $3  WHERE id = $4;"
    sql_param = [album.title, album.release_year, album.artist_id, album.id]
    DatabaseConnection.exec_params(sql, sql_param)
  end
end