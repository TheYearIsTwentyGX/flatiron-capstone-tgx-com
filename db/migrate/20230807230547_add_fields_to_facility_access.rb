class AddFieldsToFacilityAccess < ActiveRecord::Migration[6.1]
  def change
    add_column :facility_accesses, :Access_Until, :date
  end
end
