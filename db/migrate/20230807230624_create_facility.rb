class CreateFacility < ActiveRecord::Migration[6.1]
  def change
    create_table :facilities, primary_key: :Coserial do |t|
      t.string :Report_Name
      t.string :Discipline

      t.timestamps
    end
  end
end
