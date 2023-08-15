class User < ActiveRecord::Base
  has_one :access_profile, foreign_key: "id", primary_key: "Access_Profile", class_name: "AccessProfile"
  has_many :facility_accesses, foreign_key: "User_Name", primary_key: "User_Name"
  has_many :facilities, through: :facility_accesses, foreign_key: "User_ID", primary_key: "User_ID"
  has_secure_password

  scope :active, -> { where("Access_Until > ?", DateTime.now.strftime("%Y-%m-%d %H:%M:%S")) }

  
  validates :User_Name, presence: true, uniqueness: true
  validates :Access_Profile, presence: true, numericality: true
end
