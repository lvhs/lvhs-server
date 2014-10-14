class Item < ActiveRecord::Base
  belongs_to :artist
  enum type: %i(music video)
  enum billing_method: %i(free in_app_purchase reward both)
end
