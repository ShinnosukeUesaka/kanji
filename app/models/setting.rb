class Setting < ApplicationRecord
  belongs_to :user
  serialize :learning_mode_intervals, Array
  
  validates :learning_mode_intervals, inclusion: {in: [true, false]}
end
