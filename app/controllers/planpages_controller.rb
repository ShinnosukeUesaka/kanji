class PlanpagesController < ApplicationController
  def firstpage
  end

  def select
  end

  def kanken
    
  end

  def nonkanken
    
  end

  def explanation
    params[:studysets] do |set|
      if set[:create] == "true"
        @study_set = current_user.studyset.build(set.permit(:level, :yomi, :kaki, :yoji))
        @study_set.save
      end
    end
    
    current_user.studyset do |set|
      questions = Qustion.where(level: set.level).pluck(:id)
      questions do |question|
        progress  = question.progress.build.new(user_id: current_user.id, progress_params)
        progress.save
    end
    
    render action: :explanation
=begin
    @setting = current_user.setting.build(setting_params)
    @setting.save
    
    level()
    @studyset = current_user.studyset.build(studyset_params)
    @studyset.save
    
    get_problems_id(params[:level]) do |id|
      @micropost = current_user.progress.build(progress_params)
      @micropost.save
    end
=end
  end
  
  
  private
  
  def level_params
    params.require(:studysets).permit()
  end
  
  def setting_params
  end
  
  def studyset_params
  end
  
  def get_problems_id(level)
    Qustion.where(level: level).pluck(:id)
  end
end
