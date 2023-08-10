class Facilities::ContactSerializer < ActiveModel::Serializer
  attributes :Report_Name, :Coserial, :Telephone, :Fax, :Address1, :Address2, :City, :State, :Zip, :Address
  def Coserial
    object.Co_Serial
  end

  def Address
    object.Address1 + "&#x0a;" + object.Address2 + "&#x0a;" + object.City + ", " + object.State + " " + object.Zip
  end
end
