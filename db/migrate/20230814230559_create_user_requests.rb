class CreateUserRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :user_requests do |t|
      t.string :Full_Name
      t.integer :RequestType
      t.string :Status
      t.date :EffectiveDate

      t.timestamps
    end
  end
end
