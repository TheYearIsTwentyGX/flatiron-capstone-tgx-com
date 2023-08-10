class AddPhoneToFacilities < ActiveRecord::Migration[7.0]
  def change
    add_column :facilities, :Phone, :string
    add_column :facilities, :Fax, :string
    add_column :facilities, :Address1, :string
    add_column :facilities, :Address2, :string
    add_column :facilities, :City, :string
    add_column :facilities, :State, :string
    add_column :facilities, :Zip, :integer
  end
end
