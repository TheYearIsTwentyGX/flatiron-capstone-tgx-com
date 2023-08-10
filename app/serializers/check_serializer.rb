class CheckSerializer < ActiveModel::Serializer
  attributes :id, :CheckNumber, :Vendor, :Amount, :TransactionNumberAP, :VendorName, :TransactionNumber, :FacilityName, :CheckDate, :UserName, :Voided, :co_serial, :ClearBank, :Chkadvflag
end
