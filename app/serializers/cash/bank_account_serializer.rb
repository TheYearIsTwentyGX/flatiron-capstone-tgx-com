class Cash::BankAccountSerializer < ActiveModel::Serializer
  attributes :ID, :co_serial, :Bank, :Description, :StartDate, :EndDate, :AccountType, :Type
end
