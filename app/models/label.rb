class Label < ActiveRecord::Base
  has_many :artist
  has_many :staff
end
