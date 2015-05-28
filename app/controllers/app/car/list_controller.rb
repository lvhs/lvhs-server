class App::Car::ListController < App::BaseController
  def index
    iid = list_params[:iid] || cookies[:iid]
    aid = list_params[:aid] || cookies[:aid]

    redirect_to app_artist_path(id: aid, player: true) if already_rewarded?(iid)
    reward_and_redirect(iid, aid) if empty_rewarded?
    @ads = get_ads(iid)
  end

  private

  def list_params
    params.permit(:aid, :iid, :yid)
  end

  def already_rewarded?(iid)
    !PurchasedItem.find_by(key: @device.key, item_id: iid).nil?
  end

  def reward_and_redirect(iid, aid)
    item = Item.find_by(id: iid)
    pi = PurchasedItem.where(key: @device.key, item_id: nil).first
    pi.update_attributes! item_id: iid
    redirect_to app_artist_path(id: aid, player: true)
  end

  def empty_rewarded?
    pi = PurchasedItem.where(key: @device.key, item_id: nil).first
    return false if pi.nil?
    pi.item_id.nil?
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
