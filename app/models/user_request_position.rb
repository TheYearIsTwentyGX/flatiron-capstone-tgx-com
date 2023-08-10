class UserRequestPosition < MasterSecurityDbBase
  self.table_name = "User_Request_Positions"
  self.primary_key = "ID"
  scope :active, -> { where("Active_From <= ? AND Active_Until >= ?", Date.today, Date.today) }
end
