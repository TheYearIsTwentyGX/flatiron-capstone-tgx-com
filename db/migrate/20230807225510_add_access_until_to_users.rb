class AddAccessUntilToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :Access_Until, :date
  end
end
