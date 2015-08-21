# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  key        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Device < ActiveRecord::Base
  has_many :purchased_item
end
