class Label < ActiveRecord::Base
  has_many :artist
  has_many :staff
  has_many :item, through: :artist
end
