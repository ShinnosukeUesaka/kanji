class ApplicationController < ActionController::Base
  include GetToday
  include SessionsHelper
  
  private
  
  def require_user_correct(user)
    unless user == current_user
      redirect_to login_path
    end
  end
  
  def require_user_admin
    unless current_user.usertype == 1
      redirect_to login_path
    end
  end
  
  

  def require_user_logged_in
    unless logged_in?
      redirect_to login_path
    end
  end
  
  
  def check_active_update_progresses
    if current_user.active_today == false
      current_user.acitve_today = true
      current_user.save
      current_user.set_daily_show_questions
    end
  end
end
