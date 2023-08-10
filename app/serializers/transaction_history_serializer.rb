class TransactionHistorySerializer < ActiveModel::Serializer
  attributes :id, :ID, :FacilityName, :AccountName, :TransDate, :Amount, :DateEntered, :FacilityTarget, :Description, :CheckStart, :CheckEnd, :GenType, :SubType, :UserName, :Co_Serial_1, :Co_Serial_2, :PostedInTech
end
