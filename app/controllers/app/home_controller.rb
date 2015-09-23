class App::HomeController < App::BaseController
  def index
    @items = Item.available.includes(:artist).reverse
    @price = {}.tap do |price|
      @items.each do |item|
        price[item.id] = item.id == 451 ? 240 : 120
      end
    end
  end
end
