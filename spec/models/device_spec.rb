# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  key        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Device, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
