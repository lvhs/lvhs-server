class App::Car::ErrorController < App::BaseController
  def index
    render text: 'Error', status: 403
  end
end
