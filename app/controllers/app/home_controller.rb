class App::HomeController < App::BaseController
  def index
    limit = 10
    @page = (params[:p] || 1).to_i
    @items = Item.available.includes(:artist)
               .order(id: :desc).limit(limit).offset(offset(limit, @page))
    @price = build_price

    if @page > 1
      if @items.empty?
        render html: ''
      else
        render partial: 'app/home/items', locals: { items: @items, price: @price }
      end
    end
  end

  private

  def build_price
    {}.tap do |price|
      @items.each do |item|
        price[item.id] = item.id == 451 ? 240 : 120
      end
    end
  end

  def offset(limit, page)
    limit * (page - 1)
  end
end
