class App::PurchaseController < App::BaseController
  protect_from_forgery except: :create

  def create
    p = item_params
    iid = p[:iid] || ProductManager.iid(p[:pid])
    @item = Item.find_by(id: iid)
    PurchasedItem.create! key: @device.key, item_id: @item.id
    render json: { status: 'ok' }, status: 200
  end

  private

  def item_params
    params.permit(:iid, :pid)
  end
end
