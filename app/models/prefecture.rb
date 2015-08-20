# == Schema Information
#
# Table name: prefectures
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_prefectures_on_name  (name) UNIQUE
#

class Prefecture < ActiveRecord::Base
  has_many :event_sites
  has_many :event, through: :event_sites
end
