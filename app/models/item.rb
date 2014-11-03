class Item < ActiveRecord::Base
  belongs_to :artist
  enum media_type: %i(music video)
  enum billing_method: %i(free in_app_purchase reward both)

  scope :music, ->{ where(media_type: :music) }
  scope :video, ->{ where(media_type: :video) }
end
