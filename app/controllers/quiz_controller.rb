class QuizController < ApplicationController
  before_action :require_user_logged_in
  before_action :check_active_update_progresses
  
  #TODO 出題の順番を制御する
  #TODO 書き以外の問題にも対応させる
  
  def question
    @progress = current_user.show_progresses.where(answer: nil).take
    if @question
      @question = @progress.question
    else
      #出題する問題がなくなった場合
      redirect_to quiz_finished_url
    end
  end

  def answer
    #TODO: 不正な入力を防ぐ（session使う？）
    @question = question.find(id: params[:id])
    @question.answer = params[:answer]
    @question.save
  end
  
  def finished
    @user = current_user
  end
  
end