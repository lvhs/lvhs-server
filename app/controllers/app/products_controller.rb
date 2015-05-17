class App::ProductsController < App::BaseController
  def index
    render :json => ProductManager::MASTER.values
  end
end
