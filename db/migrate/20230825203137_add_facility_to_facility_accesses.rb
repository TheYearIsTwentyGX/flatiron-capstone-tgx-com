class AddFacilityToFacilityAccesses < ActiveRecord::Migration[7.0]
  def change
    add_reference :facility_accesses, :facility, null: false, foreign_key: true
    add_reference :facility_accesses, :user, null: false, foreign_key: true
  end
end
