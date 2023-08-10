class InventoryAssigned < ItDbBase
  self.table_name = "Inventory_Assigned"
  has_one :user, foreign_key: "User_ID", primary_key: "AssignedToWho"
end
