class AddProfileToFacilityAccess < ActiveRecord::Migration[7.0]
  def change
    add_column :facility_accesses, :profile, :integer
  end
end
