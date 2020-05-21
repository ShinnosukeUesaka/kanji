class Setting < ApplicationRecord
  belongs_to :user
  serialize :learning_mode_intervals, Array
  
  validates :learning_mode_intervals, presence: :true
end
