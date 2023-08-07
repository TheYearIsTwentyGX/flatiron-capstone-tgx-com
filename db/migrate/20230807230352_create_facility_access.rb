class CreateFacilityAccess < ActiveRecord::Migration[6.1]
  def change
    create_table :facility_accesses do |t|
	  t.timestamps
    end
  end
end
