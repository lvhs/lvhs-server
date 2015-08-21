# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :text(65535)
#  scheduled_at  :datetime         not null
#  event_site_id :integer          not null
#  artist_id     :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_events_on_artist_id_and_event_site_id_and_scheduled_at  (artist_id,event_site_id,scheduled_at) UNIQUE
#

class Event < ActiveRecord::Base
  belongs_to :event_site
  belongs_to :artist
  has_many :event_entries
  has_many :users, through: :event_entries
  has_one :prefecture, through: :event_site
  has_many :event_comments
  alias :comments :event_comments

  validates :event_site_id, presence: true
  validates :artist_id, presence: true
  validates :scheduled_at, presence: true
end
