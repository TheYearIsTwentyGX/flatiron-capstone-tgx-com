class AddFieldsToFacilityAccess < ActiveRecord::Migration[6.1]
  def change
    add_column :facility_accesses, :User_Name, :string
    add_column :facility_accesses, :Coserial, :int
    add_column :facility_accesses, :Access_Until, :date
  end
end
