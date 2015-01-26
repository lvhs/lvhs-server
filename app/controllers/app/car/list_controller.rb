class App::Car::ListController < App::BaseController

  def index
    # FIXME
    if Rails.env.development?
      uiid = get_uiid
      id = uiid.nil? ? 0 : Device.find_by(key: uiid).id
    else
      uiid = get_uiid
      id = Device.find_by(key: uiid).id
    end
    res = CA::Reward.new(id.to_s, iid: list_params[:iid]).get
    @ads = res.ads
  end

  private

  def list_params
    params.permit(:iid, :yid)
  end

end
