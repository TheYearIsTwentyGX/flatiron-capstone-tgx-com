class ItDbBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :IT
end
