class InventoryItem < ItDbBase
  self.table_name = "Inventory"
  self.primary_key = "AssetID"
  has_one :type, primary_key: "Type", foreign_key: "ID", class_name: "InventoryType"
  has_one :assignment, primary_key: "AssetID", foreign_key: "AssetID", class_name: "InventoryAssigned"

  scope :active, -> { where("Disposed_Date = ?", Date.new(1900, 1, 1)) }

  def attributes_for_create(attribute_names)
    super.reject { |k| k == "AssetID" || k == "ID" }
  end
end
