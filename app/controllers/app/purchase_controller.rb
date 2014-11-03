class App::PurchaseController < App::BaseController
  def create
    @item = Item.find(item_params)
    render_error if @item.nil? || @device.nil?
    PurchasedItem.create! key: @device.key, id: @item.id
    render json: { status: 'ok' }, status: 200
  end

  private

  def item_params
    params.require(:item).permit(:id)
  end
end
