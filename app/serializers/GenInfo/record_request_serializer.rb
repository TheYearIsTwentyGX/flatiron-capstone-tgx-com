class GenInfo::RecordRequestSerializer < ActiveModel::Serializer
  attributes :id, :ResidentName, :RequestParty, :RequestDate, :RequestTypeID, :RequestType, :RequestFulfilledDate, :Notes, :LastEdit_Who, :LastEdit_When, :ActiveUntil
  def RequestType
    object.request_type.Name
  end

  def ResidentName
    if object.ResidentName.present?
      object.ResidentName
    else
      "N/A"
    end
  end
end
