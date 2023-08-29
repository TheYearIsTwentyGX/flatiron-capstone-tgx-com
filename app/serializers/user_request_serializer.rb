class UserRequestSerializer < ActiveModel::Serializer
  attributes :id, :Full_Name, :User_Name, :created_at, :Facilities, :Credentials

  def Facilities
    object.facility_accesses.map do |access|
      {
        id: access.facility_id,
        Report_Name: access.facility.Report_Name,
        Access_Profile: access.profile
      }
    end
  end
end
