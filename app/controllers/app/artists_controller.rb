class App::ArtistsController < App::BaseController
  def show
    p = artist_params
    @artist = Artist.find_by_id(p[:id])
    @player = p[:player]
  end

  private

  def artist_params
    params.permit(:id, :player)
  end
end
