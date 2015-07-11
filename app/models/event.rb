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
