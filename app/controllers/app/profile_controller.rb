class App::ProfileController < App::BaseController
  def index
    user = User.find_by(@device.id)
    if user.nil?
      redirect_to :welcome_app_events
    else
      redirect_to(app_user_path(user))
    end
  end
end
