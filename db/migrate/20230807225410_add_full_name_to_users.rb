class AddFullNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :Full_Name, :string
  end
end
