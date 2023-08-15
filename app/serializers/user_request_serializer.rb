class UserRequestSerializer < ActiveModel::Serializer
  attributes :id, :Full_Name, :User_Name, :Access_Profile, :created_at, :Facilities, :Credentials, :Coserials
  def Access_Profile
		{ 
      name: object.access_profile.Friendly_Name,
      id: object.access_profile.id
    }
  end

  def Coserials
    object.facilities.pluck(:Coserial)
  end

  def Facilities
		object.facilities.select(:Report_Name, :Coserial)
  end
end
