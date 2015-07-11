class UserDecorator < Draper::Decorator
  delegate_all

  def image_url
    if object.image_path[/^profile/]
      ActionController::Base.helpers.image_url(object.image_path)
    else
      ActionController::Base.helpers.static_url(object.image_path)
    end
  end
end
