class App::Car::ListController < App::BaseController
  def index
    # FIXME
    if Rails.env.development?
      @device ||= Device.find_by(key: '165F5CAC-1469-45DC-8CFB-16CAF36D3248')
      _uiid = uiid || '165F5CAC-1469-45DC-8CFB-16CAF36D3248'
      id = Device.find_by(key: _uiid).id
    else
      id = Device.find_by(key: uiid).id
    end
    iid = list_params[:iid]

    unless PurchasedItem.find_by(key: @device.key, item_id: iid).nil?
      redirect_to app_artist_path(id: list_params[:aid], player: true)
    end

    res = CA::Reward.new(id.to_s, iid: iid).get
    reward_histories = RewardHistory.where(device_id: @device.id)
    rewarded_cids = reward_histories.select(:cid).map {|h| h.cid }
    @ads = res.ads.select { |ad| !rewarded_cids.include? ad }
  end

  private

  def list_params
    params.permit(:aid, :iid, :yid)
  end
end
