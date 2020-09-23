class QuizController < ApplicationController
  before_action :require_user_logged_in
  before_action :check_active_update_progresses
  before_action :count_questions
  
  #TODO 出題の順番を制御する
  #TODO 書き以外の問題にも対応させる
  
  def question
    if @count_left_review != 0
      @progress = current_user.show_progresses.where(category: [:young, :mature]).where(answer: [nil, 'again']).take
    elsif @count_left_new != 0
      @progress = current_user.show_progresses.where(category: [:not_seen]).where(answer: [nil, 'again']).take
    else
      redirect_to quiz_finished_url and return
    end
    @question = @progress.question
   
  end

  def answer
    @progress = Progress.find(params[:id])
    @question = @progress.question
  end
  
  def post_answer
    #TODO: 不正な入力を防ぐ（session使う？）
    @progress = Progress.find(params[:id])
    @progress.answer = params[:answer]
    @progress.save
    redirect_to quiz_question_url
  end
  
  def finished
    @user = current_user
  end
  
  
  
end