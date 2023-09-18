class UserRequestSerializer < ActiveModel::Serializer
  attributes :id, :Full_Name, :User_Name, :created_at, :Facilities, :Credentials

  def Facilities
    object.facility_accesses.map do |access|
      Facility.find(access.facility_id)
    end
  end
end
