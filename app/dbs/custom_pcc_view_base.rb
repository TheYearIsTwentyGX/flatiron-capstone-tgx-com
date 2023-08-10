class CustomPccViewBase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :CustomPCC
end
