class Device < ActiveRecord::Base
  has_many :purchased_item
end
