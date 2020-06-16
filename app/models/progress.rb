class Progress < ApplicationRecord
  require "date"
  include GetToday
  
  enum category: { not_seen: 0, young: 1, mature: 2 }
  enum answer: { again: 0, hard: 1, good: 2, easy: 3, good_after_again: 4 }
  
  belongs_to :user
  belongs_to :question
  
  validates :question_id, uniqueness: {scope: :user_id}, presence: true
  
  attribute :category, :integer,  default: 0
  attribute :active, :boolean,  default: true
  attribute :show,        :boolean, default: false
  attribute :due_date,        :date, default: get_today
  attribute :previous_answered_date,     :date, default: get_today
  attribute :learning_mode,        :boolean, default: true
  attribute :learning_mode_n,        :integer, default: 0
  
  scope :active, -> { where(active: true) }
  scope :due, -> { where(active: true).where('due_date <= ?', get_today) }
  scope :show, -> { where(active: true).where(show: true) }
  
  
  # TODO: private な　interval をチェックするメソッドを作る(DRY)
  
  
  def decimal_efactor
    return (self.efactor/100).to_f
  end
  
  
  
  def update_progress
    # next_efactor 次のeファクタ
    # next_interval 次の復習間隔（日数）
    # これらをユーザーのリスポンスから設定
    # due_date を next_interval から計算

    # ユーザーが問題に答えなかった場合は何もしない
    if self.answer == nil
      return
    end
    
  
    previous_interval = (self.previous_answered_date..self.due_date).count - 1
    actual_interval = (self.previous_answered_date..get_today).count - 1
    
    if self.learning_mode == true #初期学習 or 間違えて学び直しの場合 (learning mode)
    
      next_efactor = self.efactor
      
      case self.answer
      when 'again', 'good_after_again' then # やり直し
        
        self.learning_mode_n = 0
        next_interval = self.user.setting.learning_mode_intervals[self.learning_mode_n]
        
      when 'hard', 'good' then
        
        next_efactor = self.efactor
        
        if self.learning_mode_n == self.user.setting.learning_mode_intervals.count # learning mode 終わり
          
          if self.interval_after_learning_mode == nil
            next_interval = (actual_interval*decimal_efactor).floor
          else
            next_interval = self.interval_after_learning_mode
            self.interval_after_learning_mode = nil
          end
          self.learning_mode = false
          self.learning_mode_n = nil
          
        else 
          next_interval = self.user.setting.learning_mode_intervals[self.learning_mode_n]
          self.learning_mode_n += 1
        end
        
      when 'easy' then # learning mode 終わり
          if self.interval_after_learning_mode == nil
            next_interval = (actual_interval*decimal_efactor).floor
          else
            next_interval = self.interval_after_learning_mode
            self.interval_after_learning_mode = nil
          end
          self.learning_mode = false
          self.learning_mode_n = nil
      end


    else #普通の復習の場合
      case self.answer 
      when 'again', 'good_after_again' then
        next_efactor = self.efactor - 20
        # learning_mode の設定
        self.interval_after_learning_mode = validate_interval((previous_interval*((next_efactor/100).to_f)).floor)
        self.learning_mode = true
        self.learning_mode_n = 0
        next_interval = self.user.setting.learning_mode_intervals[self.learning_mode_n]
        
      when 'hard' then
        next_interval = (previous_interval*1.2).floor 
        next_efactor = self.efactor - 15
      when 'good' then
        next_interval = (actual_interval*decimal_efactor).floor
        next_efactor = self.efactor
      when 'easy' then 
        next_interval = (actual_interval*decimal_efactor*Settings.easy_bonus).floor
        next_efactor = self.efactor + 15
      end
      
    end
    
    next_efactor = validate_efactor(next_efactor)
    if self.learning_mode == false 
      next_interval = validate_interval(next_interval, actual_interval)
    end
    
    self.category = get_category(next_interval)
    self.efactor = next_efactor
    self.previous_answered_date = get_today
    self.due_date = get_today + next_interval
    self.answer = nil
    self.show = false
    
    self.save
    
  end
  
  private
  
  def get_category(interval)
    case interval
    when 0..21 then
      return 'young'
    else
      return'mature'
    end
  end
  
  def validate_interval(next_interval, actual_interval)
    if next_interval < actual_interval + 1 # all new intervals (except Again) will always be at least one day longer than the previous interval.
      return actual_interval+1
    end
    if next_interval > self.user.setting.max_interval && self.user.setting.max_interval!= nil
      return self.user.setting.max_interval
    end
    return next_interval
  end
  
  def validate_efactor(next_efactor)
    puts next_efactor
    if next_efactor < Settings.min_efactor
      return Settings.min_efactor
    end
    return next_efactor
  end
end