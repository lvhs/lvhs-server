require 'aws/s3/client_extensions'

class App::Users::ImageController < App::BaseController
  def edit
    @user = User.find(params[:id])
  end

  def update
    user_id = params[:id]
    @user = User.find(user_id)

    if params[:file] && params[:image]

      image = params[:image]
      /^image\/(?<ext>\w+)/ =~ image.content_type
      img = Magick::Image.from_blob(image.tempfile.read).first
      img.auto_orient!
      img.resize_to_fit!(150, 150)
      path = "user/#{user_id}/profile.#{ext}"
      Aws::S3::Client.put_object(path, img.to_blob)

      @user.image_path = path
    else
      @user.image_no = params[:image_no]
    end

    @user.save
    redirect_to app_user_path params[:id]
  end
end
