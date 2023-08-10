class MarketingDbBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :Marketing
end
