class Staff < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :label
  has_many :artist, through: :label

  validates_with StaffValidator

  enum role: %i(admin general label guest)
end
