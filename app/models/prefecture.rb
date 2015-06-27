class Prefecture < ActiveRecord::Base
  has_many :event_sites
end
