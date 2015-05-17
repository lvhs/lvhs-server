class App::Car::ListController < App::BaseController
  def index
    iid = list_params[:iid]
    aid = list_params[:aid]

    redirect_to app_artist_path(id: aid, player: true) if already_rewarded?(iid)
    @ads = get_ads(iid)
  end

  private

  def list_params
    params.permit(:aid, :iid, :yid)
  end

  def encure_device_id
    if Rails.env.development?
      @device ||= Device.find_by(key: '165F5CAC-1469-45DC-8CFB-16CAF36D3248')
    end
  end

  def already_rewarded?(iid)
    !PurchasedItem.find_by(key: @device.key, item_id: iid).nil?
  end

  def get_ads(iid)
    res = CA::Reward.new(@device.id.to_s, iid: iid).get
    reward_histories = RewardHistory.where(device_id: @device.id)
    rewarded_cids = reward_histories.select(:cid).map { |h| h.cid }
    res.ads.select { |ad| !rewarded_cids.include? ad.c_id }
    app_install_only!(res)
  end

  private

  def app_install_only!(res)
    res.ads.select! { |ad| ad.cv_points.any?{ |cp| cp.requisite_id == "1" } }
  end
end
