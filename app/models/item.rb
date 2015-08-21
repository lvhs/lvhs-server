# == Schema Information
#
# Table name: items
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  media_type       :integer          default(1), not null
#  description      :text(65535)
#  artist_id        :integer          not null
#  price            :integer
#  billing_method   :integer          default(3), not null
#  finished_at      :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  image_path       :string(255)
#  status           :integer          default(0)
#  published_at     :datetime
#  vimeo_id         :string(255)
#  apple_product_id :string(255)
#  vimeo_thumb_id   :integer
#

require 'product_manager'

class Item < ActiveRecord::Base
  belongs_to :artist
  enum media_type: %i(music video)
  enum billing_method: %i(free in_app_purchase reward both)
  enum status: %i(unavailable available)
  just_define_datetime_picker :published_at, add_to_cattr_accessor: true
  just_define_datetime_picker :finished_at, add_to_cattr_accessor: true

  scope :available, ->{
    where(status: 1)
      .where('published_at is null or published_at <= ?', Time.now)
  }

  scope :music,  -> { where(media_type: :music) }
  scope :video,  -> { where(media_type: :video) }
  scope :artist, ->(params) { joins(:artist).merge(Artist.where params) }

  def free?
    billing_method == 'free' || (!finished_at.nil? && finished_at <= Time.now)
  end

  def purchasable?
    ProductManager.purchasable? id
  end

  def pid
    ProductManager.pid id
  end

  def new?
    [published_at, created_at].compact.max > Time.current - 1.week
  end
end
