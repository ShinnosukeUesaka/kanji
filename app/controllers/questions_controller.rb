class QuestionsController < ApplicationController
  before_action :require_user_auth
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  
  def index
    @questions = Question.all
  end

  def show
    
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      flash[:success] = '作成完了'
      redirect_to @question
    else
      flash.now[:danger] = '作成失敗、、'
      render :new
    end
  end

  def edit

  end

  def update
    if @question.update(question_params)
      flash[:success] = 'タスク更新'
      redirect_to @question
    else
      flash.now[:danger] = '失敗、、'
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:success] = '削除完了'
    redirect_to questions_url
  end

  private
  
  def set_question
    @question = Question.find_by(id: params[:id])
  end
  
  def check_auth
    current
  end
  
  
  def question_params
    params.require(:question).permit(:ex_top, :kanji, :ex_buttom, :yomi, :meaning, :category, :level)
  end
end

