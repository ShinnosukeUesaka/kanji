class UsertopController < ApplicationController
  before_action :require_user_logged_in
  before_action :check_active_update_progresses
  before_action :count_questions
  def main
  end

  def setting
  end
end
