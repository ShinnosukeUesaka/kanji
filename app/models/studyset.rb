class Studyset < ApplicationRecord
  belongs_to :user
  
  validates :level, uniqueness: { scope: :user_id }
end
