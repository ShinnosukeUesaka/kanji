class Setting < ApplicationRecord
  belongs_to :user
  serialize :learning_mode_intervals, Array
  
  attribute
end
