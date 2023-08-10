class VendorAdminDbBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :VendorAdmin
end
