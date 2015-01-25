class App::Car::ListController < App::BaseController
  def index
    begin
      uiid = get_uiid || 'AAA'
      res = CA::Reward.new(uiid).get
    #rescue => e
    #  logger e
    end
    @ads = res.ads
  end
end
