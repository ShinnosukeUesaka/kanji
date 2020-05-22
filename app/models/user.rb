class User < ApplicationRecord
  require 'date'
  
  enum kanken_level: { one: 0, pre_one: 1, two: 2,  pre_two: 3, three: 4, four: 5, five: 6 , six: 7 , seven: 8 , eight: 9 , nine: 10 , ten: 11}
  
  
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  enum usertype: { normal: 0, admin: 1}
  
  has_one :setting, dependent: :destroy #??
  has_many :studysets, dependent: :destroy
  has_many :progresses, dependent: :destroy
  
  has_many :active_progresses, -> { where(active: true) }, class_name: "Progress"
  has_many :show_progresses, -> { where(active: true).where(show: true) }, class_name: "Progress"
  has_many :is_due_progresses, -> { where(active: true).where(due_date: Date.today) }, class_name: "Progress"
  has_many :questions, through: :progresses
  has_many :active_questions, through: :active_progresses, source: :question
  has_many :show_questions, through: :show_progresses, source: :question
  has_many :is_due_questions, through: :is_due_progresses, source: :question
  
  
  
  #https://qiita.com/QUANON/items/a58ff3960b43af472bfb
  
  #when user logs in(only once a day) doesn't have to be everyday
  def set_daily_show_questions()
    show_progresses = []
    
    if self.setting.max_total_questions == null
      #最大合計問題数を設定しなかった（なし）場合:
      #期日の復習問題全てと
      #新規の問題を最大新規問題数までを出題
      show_progresses << self.is_due_progresses.where.not(categoery: 'new')
      show_progresses << self.is_due_progresses.where(categoery: 'new').limit(self.setting.max_new_questions)
    else
      
      #１日の最大合計問題数を設定した場合：
      #新規問題より期日の復習問題を優先して出題し、１日の最大合計数を超える問題については次の日に回す。
      #つまり、、、
      #出題する復習問題の数=Min(期日の復習問題の数、１日の最大合計問題数）
      #出題する新規問題の数=Min(１日の最大合計問題数ー期日の復習問題の数,　１日の最大新規問題数)
      if self.setting.max_total_questions >= self.is_due_progresses.where.not(categoery: 'new').count
        show_progresses << self.is_due_progresses.where.not(categoery: 'new')
        n_new_progresses = [self.setting.max_new_questions - self.is_due_progresses.where.not(categoery: 'new').count, self.setting.max_new_questions].Min
        show_progresses << self.is_due_progresses.where(categoery: 'new').limit(n_new_progresses)
      else
        show_progresses << self.is_due_progresses.where.not(categoery: 'new').limit(self.setting.max_total_questions)
      end
    end
    
    
    show_progresses.map {|progress| progress.show = true}
    
  end
  
  #on nights when user logged in 
  def update_progresses()
    self.show_progresses.each do |progress|
      progress.update_progress
      progress.show = false
    end
  end
    
end
