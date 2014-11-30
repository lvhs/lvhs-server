class Artist < ActiveRecord::Base
  belongs_to :artist_group
  has_many :item
  enum status: %i(unavailable available)
  just_define_datetime_picker :published_at, :add_to_cattr_accessor => true

  validate :key_should_be_particular_format

  scope :available, ->{
    where(status: 1)
    .where('published_at is null or published_at <= ?', Time.now)
  }

  private

  def key_should_be_particular_format
    unless key[/\A[a-z0-9_-]+\z/]
      errors.add(:key, 'は英数字と記号(-_)のみ使用できます。')
    end
  end
end
