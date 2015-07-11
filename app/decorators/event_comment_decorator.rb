class EventCommentDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  def as_json(option = {})
    super as_json_default_option.merge(option)
  end

  def deco_created_at
    object.created_at.strftime('%m/%d %H:%M')
  end

  private

  def as_json_default_option
    {
      only: [:body, :created_at, :user_id],
      methods: [:deco_created_at],
      include: {
        user: {
          only: [:id, :name, :image_path],
          methods: [ :image_url ]
        }
      }
    }
  end
end
