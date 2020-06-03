class ApplicationController < ActionController::Base
  include GetToday
  include SessionsHelper
  
  private
  
  def count_questions
    #@count_total_due = current_user.is_due_progresses.count
    @count_total_new = current_user.show_progresses.where(category: [:new]).count
    @count_total_review = current_user.show_progresses.where(category: [:young, :mature]).count
    @count_left_new = current_user.show_progresses.where(category: [:new]).where(answer: [nil, 'again']).count
    @count_left_review = current_user.show_progresses.where(category: [:young, :mature]).where(answer: [nil, 'again']).count
  end
  
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
