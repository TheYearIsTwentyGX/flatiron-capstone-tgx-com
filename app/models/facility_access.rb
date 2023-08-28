class FacilityAccess < ActiveRecord::Base
  belongs_to :facility
  belongs_to :user
  has_one :access_profile, foreign_key: "id", primary_key: "Profile", class_name: "AccessProfile"

  scope :active, -> { where("[facility_accesses].Access_Until > ?", DateTime.now) }
end
