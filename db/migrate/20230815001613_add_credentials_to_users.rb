class AddCredentialsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :Credentials, :string
  end
end
