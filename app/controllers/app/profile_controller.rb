class App::ProfileController < App::BaseController
  def index
    user = User.find_or_create_by_device_id(@device.id)
    redirect_to(app_user_path(user))
  end
end
