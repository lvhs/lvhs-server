class Teaser::HomeController < Teaser::BaseController
  def index
    session[:test] = 'ok'
    #render json: { ok: true }, status: 200
  end
end
