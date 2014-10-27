class App::ArtistsController < ApplicationController
  def show
    @artist = Artist.find_by_id(params[:id])
  end
end
