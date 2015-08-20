# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  lead        :string(255)
#  description :text(65535)
#  device_id   :integer          not null
#  image_path  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  role        :integer          default(0)
#
# Indexes
#
#  index_users_on_device_id  (device_id) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
