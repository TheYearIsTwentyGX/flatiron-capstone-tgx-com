class UserRequest < MasterSecurityDbBase
  self.table_name = "User_Request"
  self.primary_key = "ID"

  validates :FirstName, :LastName, :User_Position, presence: true
  validates :Request_Who, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :Buildings, presence: true, length: {minimum: 1}
  validate :RequestingAccess, :DocRequirements

  def RequestingAccess
    unless Access_Aegis || Access_Carewatch || Access_Galaxy || Access_LTC || Access_PCC || Access_POC || Access_Riskwatch || Access_SmartZone || Access_TechGap || Access_UBwatch || Access
      errors.add(:base, "Must select at least one system to access")
    end
  end

  def DocRequirements
    access = UserRequestPosition.find_by(User_Position: User_Position)
    if access.Agreement_BYOD && Signature_BYOD.nil?
      errors.add(:base, "Must sign BYOD agreement")
    end
    if access.Agreement_EHR && Signature_EHR.nil?
      errors.add(:base, "Must sign EHR agreement")
    end
    if access.RequireCredentials && Credentials&.empty?
      errors.add(:base, "Must provide user's credentials")
    end
  end
end
