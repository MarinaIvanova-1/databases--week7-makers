require 'database_connection'
require 'album'

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

end