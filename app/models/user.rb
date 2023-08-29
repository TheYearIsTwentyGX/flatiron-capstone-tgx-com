class User < ActiveRecord::Base
  has_many :facility_accesses
  has_many :facilities, through: :facility_accesses
  has_secure_password

  scope :active, -> { where("Access_Until > ?", DateTime.now.strftime("%Y-%m-%d %H:%M:%S")) }

  validates :User_Name, presence: true, uniqueness: true
  validates :Full_Name, presence: true
end
