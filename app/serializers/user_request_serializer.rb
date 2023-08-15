class UserRequestSerializer < ActiveModel::Serializer
  attributes :id, :Full_Name, :User_Name, :Access_Profile, :created_at, :Facilities
  def Access_Profile
		object.access_profile.Friendly_Name
  end

  def Facilities
		object.facilities.pluck(:Report_Name)
  end
end
