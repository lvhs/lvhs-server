class App::PurchaseController < App::BaseController
  protect_from_forgery :except => :create

  def create
    @item = Item.find_by(item_params)
    render_error if @item.nil? || @device.nil?
    PurchasedItem.create! key: @device.key, item_id: @item.id
    render json: { status: 'ok' }, status: 200
  end

  private

  def item_params
    params.permit(:id)
  end
end
