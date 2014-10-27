class App::HomeController < App::BaseController
  def index
    @artists = Artist.all
  end
end

