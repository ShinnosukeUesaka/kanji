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
    params.permit
    p params[:studysets][:"1"]
    params[:studysets].each do |level, set_params|
      p set_params[:create]
      if set_params[:create] == "true"
        @study_set = current_user.studysets.build(set_params.permit(:level, :active, :kaki_active, :yomi_active, :yoji_active, :study_began_on))
        @study_set.save
      end
    end
    
    current_user.studysets do |set|
      questions = Qustion.where(level: set.level).pluck(:id)
      questions do |question|
        progress  = question.progress.build.new(user_id: current_user.id, kaki: set.kaki, yomi: set.yomi, yoji: set.yoji)
        progress.save
      end
    end
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
  
  
  private
  
  def level_params
    params.require(:studysets).permit()
  end
  
  def level_params
  end
=begin
  def progress_params
    params.require(:test)
  end

  def setting_params
  end
  
  def studyset_params
  end
=end
  def get_problems_id(level)
    Qustion.where(level: level).pluck(:id)
  end
  
end
