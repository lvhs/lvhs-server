class Item < ActiveRecord::Base
  belongs_to :artist
  enum media_type: %i(music video)
  enum billing_method: %i(free in_app_purchase reward both)
  enum status: %i(unavailable available)
  just_define_datetime_picker :published_at, :add_to_cattr_accessor => true
  just_define_datetime_picker :finished_at, :add_to_cattr_accessor => true

  scope :available, ->{
    where(status: 1)
    .where('published_at is null or published_at <= ?', Time.now)
  }

  scope :music,  ->{ where(media_type: :music) }
  scope :video,  ->{ where(media_type: :video) }
  scope :artist, ->(params){ joins(:artist).merge(Artist.where params) }

  def free?
    billing_method == "free" || (!finished_at.nil? && finished_at <= Time.now)
  end

end
