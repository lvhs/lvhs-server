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

require 'rails_helper'

RSpec.describe PurchasedItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
