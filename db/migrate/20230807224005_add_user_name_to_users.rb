class AddUserNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :User_Name, :string
  end
end
