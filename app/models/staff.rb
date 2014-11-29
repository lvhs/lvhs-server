class Staff < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :artist_group
  has_many :artist, through: :artist_group
  has_many :item, through: :artist

  validates_with StaffValidator

  enum role: %i(admin general label guest)
end
