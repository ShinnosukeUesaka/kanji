class ApplicationRecord < ActiveRecord::Base
  include GetToday
  self.abstract_class = true
end
