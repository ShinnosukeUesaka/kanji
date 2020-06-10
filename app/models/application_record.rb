class ApplicationRecord < ActiveRecord::Base
  extend GetToday
  self.abstract_class = true
end
