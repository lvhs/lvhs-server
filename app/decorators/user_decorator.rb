class UserDecorator < Draper::Decorator
  delegate_all

  def image_url
    ActionController::Base.helpers.image_url(object.image_path)
  end
end
