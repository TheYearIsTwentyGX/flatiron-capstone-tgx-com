class CashDbBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :Cash
end
