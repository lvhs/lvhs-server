class App::Car::ListController < App::BaseController
  def index
    begin
      res = CA::Reward.new('AAA').get
    rescue => e
      logger e
    end
    @ads = res.ads
  end
end
