class CreateAccessProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :access_profiles do |t|
      t.string :Friendly_Name
      t.string :Department
      t.string :Title
      t.boolean :IsAdmin

      t.timestamps
    end
  end
end
