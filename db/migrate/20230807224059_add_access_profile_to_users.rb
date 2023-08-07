class AddAccessProfileToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :Access_Profile, :int
  end
end
