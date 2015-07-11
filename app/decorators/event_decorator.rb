class EventDecorator < Draper::Decorator
  decorates_association :artist

  delegate_all

  def deco_scheduled_at
    object.scheduled_at.strftime('%Y/%m/%d')
  end

  def as_json(option = {})
    super as_json_default_option.merge(option)
  end

  private

  def as_json_default_option
    {
      methods: [:deco_scheduled_at],
      include: {
        event_site: {},
        prefecture: {},
        artist: {
          methods: [:image_url]
        }
      }
    }
  end
end
