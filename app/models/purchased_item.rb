class PurchasedItem < ActiveRecord::Base
  belongs_to :device
  has_many :item
end
