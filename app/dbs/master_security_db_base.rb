class MasterSecurityDbBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :MasterSecurity
end
