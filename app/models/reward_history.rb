class RewardHistory < ActiveRecord::Base
  has_one :item
  belongs_to :device
end
