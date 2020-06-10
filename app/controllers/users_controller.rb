class UsersController < ApplicationController
  before_action ->{
    require_user_correct(User.find(params[:id]))
  }, only: [:show, :destroy]
  
  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      session[:user_id] = @user.id
      redirect_to plan_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end


  def show
    @user = User.find(params[:id])
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = '退会完了'
    redirect_to root_url
  end


  private
  
  def user_params
    params.require(:user).permit(:active_today, :name, :email, :age, :password, :password_confirmation, :usertype)
  end
end
