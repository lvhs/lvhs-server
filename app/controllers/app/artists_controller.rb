class App::ArtistsController < App::BaseController
  def show
    p = artist_params
    @artist = Artist.find(p[:id])
    # TODO:
    @price = {}.tap do |price|
      @artist.item.available.each do |item|
        price[item.id] = item.id == 451 ? 240 : 120
      end
    end
    if @artist.id == 1
      @items = @artist.item.available.to_a.sort_by!{ |item| item.id == 451 ? 462 : item.id }.reverse
    else
      @items = @artist.item.available.reverse
    end
    @player = p[:player]
  end

  private

  def artist_params
    params.permit(:id, :player)
  end
end
