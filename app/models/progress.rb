class Progress < ApplicationRecord
  require "date"
  
  enum category: { not_seen: 0, young: 1, mature: 2 }
  
  belongs_to :user
  belongs_to :question
  
  validates :question_id, uniqueness: {scope: :user_id}, presence: true
  
  attribute :category, :integer,  default: 0
  attribute :active, :boolean,  default: true
  attribute :is_due,        :boolean, default: false
  attribute :due_date,        :date, default: null
  attribute :previous_due_date,        :date, default: null
  attribute :learning_mode,        :boolean, default: true
  attribute :learning_mode_n,        :integer, default: 0
  
  
end