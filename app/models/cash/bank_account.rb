class Cash::BankAccount < CashDbBase
  self.table_name = "BankAccounts"
  scope :active, -> { where("EndDate > ?", Date.today) }
end
