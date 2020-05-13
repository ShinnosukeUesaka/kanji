class Progress < ApplicationRecord
  belongs_to :user
  belongs_to :question
  serialize :intervals
  
  attribute :active, :boolean,  default: true
end
