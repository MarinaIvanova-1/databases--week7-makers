require_relative 'lib/database_connection'
require_relative 'lib/album'
require_relative 'lib/album_repository'

DatabaseConnection.connect('music_library')


repo = AlbumRepository.new

repo.all.each do |album|
  puts "#{album.id} - #{album.title} - #{album.release_year}"
end