class Item < ActiveRecord::Base
  belongs_to :artist
  enum media_type: %i(music video)
  enum billing_method: %i(free in_app_purchase reward both)
end
