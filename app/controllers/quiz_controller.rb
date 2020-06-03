class QuizController < ApplicationController
  before_action :require_user_logged_in
  before_action :check_active_update_progresses
  before_action :count_questions
  
  #TODO 出題の順番を制御する
  #TODO 書き以外の問題にも対応させる
  
  def question
    # if @count_left_review != 0
    #   @question = current_user.show_progresses.where(category: [:young, :mature]).where(answer: [nil, 'again']).take
    # else if @count_left_new != 0
    #   @question = current_user.show_progresses.where(category: [:new]).where(answer: [nil, 'again']).take
    # else 
      
    #   redirect_to quiz_finished_url
    # end
    
      @progress = current_user.progresses.take #仮テスト用
      @question = @progress.question
  end

  def answer
    #TODO: 不正な入力を防ぐ（session使う？）
    @progress = Progress.find(params[:id])
    @progress.answer = params[:answer]
    @progress.save
    @question = @progress.question
  end
  
  def finished
    @user = current_user
  end
  
end