class EventSite < ActiveRecord::Base
  belongs_to :prefecture
  has_many :events
end
