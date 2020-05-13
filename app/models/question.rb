class Question < ApplicationRecord
  enum category: { kaki: 0, yomi: 1, yoji: 2}
  enum level: { one: 0, pre_one: 1, two: 2,  pre_two: 3, three: 4, four: 5, five: 6 , six: 7 , seven: 8 , eight: 9 , nine: 10 , ten: 11}
  
  self.inheritance_column = :sti_disabled
  
  validates :category, presence: true
  validates :level, presence: true
  validates :kanji, presence: true, length: { maximum: 10 }
  validates :yomi, presence: true, length: { maximum: 10 }
  
  attribute :meaning, :string,  default: ''
  attribute :ex_top, :string,  default: ''
  attribute :ex_buttom, :string,  default: ''
  
  
  
  has_many :progresses
end