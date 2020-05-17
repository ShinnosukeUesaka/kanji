class User < ApplicationRecord
  enum kanken_level: { one: 0, pre_one: 1, two: 2,  pre_two: 3, three: 4, four: 5, five: 6 , six: 7 , seven: 8 , eight: 9 , nine: 10 , ten: 11}
  
  
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  enum usertype: { normal: 0, auth: 1}
  
  has_one :setting, dependent: :destroy #??
  has_many :studysets, dependent: :destroy
  has_many :progresses, dependent: :destroy
  
  has_many :active_progresses, -> { where(active: true) }, class_name: "Progress"
  has_many :due_progresses, -> { where(active: true).where(is_due: true) }, class_name: "Progress"
  has_many :questions, through: :progresses
  has_many :active_questions, through: :active_progresses, source: :questions
  has_many :is_due_questions, through: :is_due_progresses, source: :questions
  
  
  
  
  #https://qiita.com/QUANON/items/a58ff3960b43af472bfb
  
  def feed_due_questions
    User.active_questions.where(is_due: true)
  end
end
