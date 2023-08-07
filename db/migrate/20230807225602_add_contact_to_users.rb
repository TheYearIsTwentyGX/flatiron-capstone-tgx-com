class AddContactToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :Email_Address, :string
    add_column :users, :Phone, :string
    add_column :users, :Extension, :int
  end
end
