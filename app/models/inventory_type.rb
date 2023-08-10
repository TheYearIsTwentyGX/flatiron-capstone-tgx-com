class InventoryType < ItDbBase
  self.table_name = "Inventory_Types"
  belongs_to :InventoryItem
end
