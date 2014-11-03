class App::ArtistsController < App::BaseController
  def show
    @artist = Artist.find_by_id(params[:id])
  end
end
