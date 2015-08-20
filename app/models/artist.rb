# == Schema Information
#
# Table name: artists
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  key             :string(255)
#  description     :text(65535)
#  artist_group_id :integer          not null
#  created_at      :datetime
#  updated_at      :datetime
#  official_url    :string(255)
#  image_path      :string(255)
#  status          :integer          default(0)
#  published_at    :datetime
#

class Artist < ActiveRecord::Base
  belongs_to :artist_group
  has_many :item
  enum status: %i(unavailable available)
  just_define_datetime_picker :published_at, add_to_cattr_accessor: true

  validate :key_should_be_particular_format
  validates :key, uniqueness: true

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
