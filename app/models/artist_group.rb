# == Schema Information
#
# Table name: artist_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ArtistGroup < ActiveRecord::Base
  has_many :artist
  has_many :staff
  has_many :item, through: :artist
end
