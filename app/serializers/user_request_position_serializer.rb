class UserRequestPositionSerializer < ActiveModel::Serializer
  attributes :ID, :Active_From, :Active_Until, :Agreement_BYOD, :Agreement_EHR, :RequireCredentials, :Agreement_RemoteAccess
end
