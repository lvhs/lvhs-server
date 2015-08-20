# == Schema Information
#
# Table name: purchased_items
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  item_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class PurchasedItem < ActiveRecord::Base
  belongs_to :device
  has_many :item
end
