class Api::ProgressesController < ApplicationController
  def show
    not_seen = current_user.progresses.where(category: 'not_seen').count
    young = current_user.progresses.where(category: 'young').count
    mature = current_user.progresses.where(category: 'mature').count
    render json: {status: 'SUCCESS', not_seen: not_seen, young: young, mature: mature}
  end
end
