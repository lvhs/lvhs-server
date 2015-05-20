class App::PurchaseController < App::BaseController
  protect_from_forgery except: :create

  def create
    p = item_params
    logger.info("iid: #{p[:iid]}")
    logger.info("pid: #{p[:pid]}")
    iid = p[:iid] || ProductManager.iid(p[:pid])
    logger.info("iid!: #{p[:pid]}")
    @item = Item.find_by(id: iid)
    logger.info("item?: #{@item.nil?}")
    logger.info("device?: #{@device.nil?}")
    render_error if @item.nil? || @device.nil?
    logger.info("not error #{@device.key} #{@item.id}")
    PurchasedItem.create! key: @device.key, item_id: @item.id
    logger.info("created!")
    render json: { status: 'ok' }, status: 200
  end

  private

  def item_params
    params.permit(:iid, :pid)
  end
end
