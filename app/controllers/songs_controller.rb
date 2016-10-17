class SongsController < ApplicationController
  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
    song = Song.create(params[:song])

    params[:genres].each do |genre|
      SongGenre.create(song_id: song.id, genre_id: genre.to_i)
    end

    song.artist = Artist.find_or_create_by(params[:artist])
    song.save

    redirect to "/songs/#{song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.name = params[:song][:name]
    @song.artist = Artist.find_or_create_by(params[:artist])

    SongGenre.where("song_id = ?", @song.id).destroy_all
    params[:genres].each do |genre|
      SongGenre.create(song_id: @song.id, genre_id: genre.to_i)
    end

    @song.save
    @updated = true
    erb :"/songs/show"
  end

end
