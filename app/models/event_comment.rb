# == Schema Information
#
# Table name: event_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  event_id   :integer          not null
#  body       :text(65535)      not null
#  image_path :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventComment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
end
