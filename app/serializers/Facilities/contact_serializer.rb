class Facilities::ContactSerializer < ActiveModel::Serializer
  attributes :Report_Name, :id, :Telephone, :Fax, :Address1, :Address2, :City, :State, :Zip, :Address

  def Address
    object.Address1 + "&#x0a;" + object.Address2 + "&#x0a;" + object.City + ", " + object.State + " " + object.Zip
  end
end
