class GenInfo::LawsuitSerializer < ActiveModel::Serializer
  attributes :id, :Co_Serial, :Plaintiff, :PlaintiffAttorney, :DefendantAttorney, :LawsuitTypeID, :LawsuitType, :IncidentDate, :FiledDate, :ResolvedDate, :Outcome, :Notes, :LastEdit_Who, :LastEdit_When, :ActiveUntil
  def LawsuitType
    object.lawsuit_type.Name
  end

  def ResolvedDate
    if object.ResolvedDate.present?
      object.ResolvedDate
    else
      "N/A"
    end
  end

  def Outcome
    if object.Outcome.present?
      object.Outcome
    else
      "N/A"
    end
  end
end
