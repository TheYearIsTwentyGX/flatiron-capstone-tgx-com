class GenInfoDbBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :GenInfo
end
