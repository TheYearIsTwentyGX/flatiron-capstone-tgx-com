class GenInfo::LawsuitSerializerTgx < ActiveModel::Serializer
  attributes :id, :Plaintiff, :Plaintiff_Attorney, :DefendantAttorney, :LawsuitTypeID, :LawsuitType, :IncidentDate, :FiledDate, :ResolvedDate, :Outcome, :Notes, :LastEdit_Who, :LastEdit_When, :ActiveUntil
  def LawsuitType
    object.lawsuit_type.Name
  end

  def Plaintiff_Attorney
    object.PlaintiffAttorney
  end
end
