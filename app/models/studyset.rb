class Studyset < ApplicationRecord
  belongs_to :user
  
  validates :level, uniqueness: { scope: :user_id }
  
  def check_question_category(question)
    case question.category
    when "kaki" then
      return self.kaki_active
    when "yomi" then
      return self.yomi_active
    when "yoji" then
      return self.yoji_active
    else
      return false # error!!! # Todo error 処理ちゃんとやる
    end
  end
  
end
