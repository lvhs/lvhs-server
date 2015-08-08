class App::ArtistsController < App::BaseController
  def show
    p = artist_params
    @artist = Artist.find(p[:id])
    @price = {}.tap do |price|
      @artist.item.available.each do |item|
        price[item.id] = item.id == 451 ? 240 : 120
      end
    end
    @player = p[:player]
  end

  private

  def artist_params
    params.permit(:id, :player)
  end
end
