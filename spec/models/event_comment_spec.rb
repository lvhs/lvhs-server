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

require 'rails_helper'

RSpec.describe EventComment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
