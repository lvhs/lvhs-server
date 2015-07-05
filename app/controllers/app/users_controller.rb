class App::UsersController < App::BaseController
  def show
    puts params
    @user = User.find(params[:id])
    puts @user
    @visitor = User.find_or_create_by_device_id(@device.id)
    puts @visitor
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    user_param = params.require(:user).permit(:name, :description)
    if @user.update! user_param
      redirect_to app_user_path(@user)
    else
      redirect_to edit_app_user_path(@user)
    end
  end

end
