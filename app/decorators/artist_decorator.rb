class ArtistDecorator < Draper::Decorator
  delegate_all

  def as_json(option = {})
    super as_json_default_option.merge(option)
  end

  def image_url
    ActionController::Base.helpers.static_url(object.image_path)
  end

  private

  def as_json_default_option
    {
      methods: [:image_url]
    }
  end
end
