class EventEntryDecorator < Draper::Decorator
  delegate_all

  def as_json(option = {})
    super as_json_default_option.merge(option)
  end

  private

  def as_json_default_option
    {

    }
  end
end
