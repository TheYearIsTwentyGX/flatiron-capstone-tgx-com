class FacilityAccess < ActiveRecord::Base
  belongs_to :facility, primary_key: "Coserial", foreign_key: "Coserial"
  belongs_to :user, primary_key: "User_Name", foreign_key: "User_Name"

  scope :active, -> { where("[Facility_Access].Access_Until > ?", DateTime.now) }
end
