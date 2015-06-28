class Prefecture < ActiveRecord::Base
  has_many :event_sites
  has_many :event, through: :event_sites
end
