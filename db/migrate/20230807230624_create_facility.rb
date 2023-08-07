class CreateFacility < ActiveRecord::Migration[6.1]
  def change
    create_table :facilities do |t|
      t.integer :Coserial
      t.string :Report_Name
      t.string :Discipline

      t.timestamps
    end
  end
end
