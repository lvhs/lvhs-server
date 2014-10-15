class App::Ca::ErrorController < App::BaseController
  def index
    render text: 'Error', status: 200
  end
end
