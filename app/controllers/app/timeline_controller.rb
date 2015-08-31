class App::TimelineController < App::BaseController
  def index
    @items = Item.available.includes(:artist).reverse
  end
end

