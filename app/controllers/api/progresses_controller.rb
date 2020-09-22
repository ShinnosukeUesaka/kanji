class Api::ProgressesController < ApplicationController
  def show
    
    if params[:level]
      level = params[:level]
      progresses_all = current_user.progresses.joins(:question).where(questions: {level: level})
    else
      progresses_all = current_user.progresses
    end
    
    not_seen = progresses_all.where(category: 'not_seen').count
    young = progresses_all.where(category: 'young').count
    mature = progresses_all.where(category: 'mature').count
    
    render json: {status: 'SUCCESS', not_seen: not_seen, young: young, mature: mature}
  
  end
end

