require_relative '../config/environment'

songlist = Dir.entries('db/data').select {|entry| entry.include?("mp3")}.map do |song|
  song.gsub!(/[\[\]]/, " - ").split(" - ").take(3)
end

songlist.each do |songs|
  artist = Artist.find_or_create_by(name: songs[0])
  genre = Genre.find_or_create_by(name: songs[2])
  song = Song.find_or_create_by(name: songs[1].strip, artist_id: artist.id)
  sg = SongGenre.find_or_create_by(genre_id: genre.id, song_id: song.id)
end
