class ClinicalDataDbBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :Clinical
end
