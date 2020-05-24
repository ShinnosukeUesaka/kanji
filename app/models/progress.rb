class Progress < ApplicationRecord
  require "date"
  
  enum category: { not_seen: 0, young: 1, mature: 2 }
  enum answer: { again: 0, hard: 1, good: 2, easy: 3, good_after_again: 4 }
  
  belongs_to :user
  belongs_to :question
  
  validates :question_id, uniqueness: {scope: :user_id}, presence: true
  
  attribute :category, :integer,  default: 0
  attribute :active, :boolean,  default: true
  attribute :show,        :boolean, default: false
  attribute :learning_mode,        :boolean, default: true
  attribute :learning_mode_n,        :integer, default: 0
  
  def decimal_e_factor
    return (self.e_factor/100).to_f
  end 
  
  
  
  def update_progress
    # next_e_factor 次のeファクタ
    # next_interval 次の復習間隔（日数）
    # これらをユーザーのリスポンスから設定
    # due_date を next_interval から計算

    # ユーザーが問題に答えなかった場合は何もしない
    if self.answer == nil
      return
    end
    
    
    
    previous_interval = (self.previous_due_date..self.due_date).count
    actual_interval = (self.previous_due_date..get_today).count
    
    if self.learning_mode == true #初期学習 or 間違えて学び直しの場合
      self.learning_mode_n += 1
      if self.learning_mode_n = self.user.setting.learning_mode_intervals.count
        self.learning_mode = false
        self.learning_mode_n = nil
        
        next_e_factor = self.e_factor
        next_interval = self.interval_after_learning_mode
        self.interval_after_learning_mode = false
      else
        next_e_factor = self.e_factor
        next_interval = self.user.setting.learning_mode_intervals[self.learning_mode_n]
      end

    else #普通の復習の場合
      case self.answer 
      when 'again', 'good_after_again' then
        next_e_factor = [self.e_factor - 20, Settings.minimum_e_factor].max
        # learning_mode の設定
        self.interval_after_learning_mode = (previous_interval*next_e_factor).floor
        self.learning_mode = true
        self.learning_mode_n = 0
        next_interval = self.user.setting.learning_mode_intervals[self.learning_mode_n]
        
      when 'hard' then
        new_interval = [(previous_interval*1.2).floor, previous_interval + 1].max # all new intervals (except Again) will always be at least one day longer than the previous interval.
        next_e_factor = [self.e_factor - 15, Settings.minimum_e_factor].max
      when 'good' then
        new_interval = [(actual_interval*decimal_efactor).floor, actual_interval + 1].max 
        next_e_factor = self.e_factor
      when 'easy' then 
        new_interval = [(actual_interval*decimal_efactor*Settings.Settings.easy_bonus).floor, actual_interval + 1].max
        next_e_factor += 15
    end
    
    
    set_category(next_interval)
    
    self.e_factor = next_e_factor
    self.previous_due_date = self.due_date
    self.due_date = self.due_date + next_interval
    self.answer = nil
    
    
    
    
  end
  
  
  def set_category(interval)
    case interval
    when 0..21 then
      self.category = 'young'
    else
      self.category = 'matyre'
  end
  
end