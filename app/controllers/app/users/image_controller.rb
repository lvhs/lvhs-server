class App::Users::ImageController < App::BaseController
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.image_no = params[:image_no]
    @user.save
    redirect_to app_user_path params[:id]
  end
end
