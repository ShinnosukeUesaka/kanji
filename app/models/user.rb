class User < ApplicationRecord
  require 'date'
  
  enum kanken_level: { one: 0, pre_one: 1, two: 2,  pre_two: 3, three: 4, four: 5, five: 6 , six: 7 , seven: 8 , eight: 9 , nine: 10 , ten: 11}
  enum usertype: { normal: 0, admin: 1}
  
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :active_today, inclusion: {in: [true, false]}
  has_secure_password
  
 
  
  has_one :setting, dependent: :destroy
  has_many :studysets, dependent: :destroy
  has_many :progresses, dependent: :destroy
  
  has_many :active_progresses, -> { where(active: true) }, class_name: "Progress"
  has_many :show_progresses, -> { where(active: true).where(show: true) }, class_name: "Progress"
  has_many :is_due_progresses, -> { where(active: true).where('due_date <= ?', get_today) }, class_name: "Progress"
  
  has_many :questions, through: :progresses
  has_many :active_questions, through: :active_progresses, source: :question
  has_many :show_questions, through: :show_progresses, source: :question
  has_many :is_due_questions, through: :is_due_progresses, source: :question
  
  
  
  #https://qiita.com/QUANON/items/a58ff3960b43af472bfb
  
  #when user logs in(only once a day) doesn't have to be everyday
  #TODO: 新規問題がなくなった時の処理
  def set_daily_show_questions()
    show_progresses = []
    
    # if self.setting.max_total_questions == nil
    #   #最大合計問題数を設定しなかった（なし）場合:
    #   #期日の復習問題全てと
    #   #新規の問題を最大新規問題数までを出題
    #   puts 'test1'
    #   n_review = self.is_due_progresses.where.not(category: 'not_seen').count
    #   n_new = self.setting.max_new_questions
    #   show_progresses.concat(self.is_due_progresses.where.not(category: 'not_seen').to_a)
    #   show_progresses.concat(self.is_due_progresses.where(category: 'not_seen').order(:due_date).limit(self.setting.max_new_questions).to_a)
    # else
      
    #   #１日の最大合計問題数を設定した場合：
    #   #新規問題より期日の復習問題を優先して出題し、１日の最大合計数を超える問題については別の日に回す。
    #   #つまり、、、
    #   #出題する復習問題の数=Min(期日の復習問題の数、１日の最大合計問題数）
    #   #出題する新規問題の数=Min(１日の最大合計問題数ー期日の復習問題の数,　１日の最大新規問題数)
    #   n_review = 
    #   if self.setting.max_total_questions >= self.is_due_progresses.where.not(category: 'not_seen').count
    #     puts 'test2'
    #     show_progresses.concat(self.is_due_progresses.where.not(category: 'not_seen').to_a)
    #     n_new_progresses = [self.setting.max_total_questions - self.is_due_progresses.where.not(category: 'not_seen').count, self.setting.max_new_questions].min
    #     puts 'new count' + n_new_progresses.to_s
    #     show_progresses.concat(self.is_due_progresses.where(category: 'not_seen').limit(n_new_progresses).to_a)
    #   else
    #     puts 'test3'
    #     show_progresses.concat(self.is_due_progresses.where.not(category: 'not_seen').order(:due_date).limit(self.setting.max_total_questions).to_a)
    #   end
    # end
    
    show_progresses.concat(self.is_due_progresses.where(category: 'not_seen').limit(self.setting.max_new_questions).to_a)
    show_progresses.concat(self.is_due_progresses.where.not(category: 'not_seen').order(:due_date).limit(self.setting.max_review_questions).to_a)
  
    
    show_progresses.each do |progress| 
      progress.show = true
      progress.save
    end
    
  end
  
  #on nights when user logged in 
  def update_progresses()
    self.show_progresses.each do |progress|
      progress.update_progress
    end
  end
    
end
