class PlanpagesController < ApplicationController
  before_action :require_user_logged_in
  
  def firstpage
  end

  def select
  end

  def kanken
    
  end

  def nonkanken
    
  end

  def explanation
    
    # user.settingの作成
    @setting = current_user.build_setting(params.require(:setting).permit(:max_new_questions, :max_review_questions, :init_efactor, :auto_init_efactor, :max_interval))
    @setting.learning_mode_intervals = Settings.default_learning_mode_intervals
    @setting.save
    puts @setting.errors.full_messages
    
    progresses = []
    # user.studysetsとuser.progresses  の作成
    params[:studysets].each do |level, set_params|
      if set_params[:create] == "true"
        @study_set = current_user.studysets.build(set_params.permit(:level, :active, :kaki_active, :yomi_active, :yoji_active, :study_began_on))
        @study_set.save
        
        questions = Question.where(level: @study_set.level)
        
        questions.each do |question|
          if @study_set.check_question_category(question) == true
            # https://qiita.com/xhnagata/items/79184ded56158ea1b97a  BulkInsert
            progresses << question.progresses.build(user_id: current_user.id, efactor: current_user.setting.init_efactor, category: 'not_seen')
            #logger.debug @progress.errors.inspect 
          end
        end
      end
    end
    Progress.import progresses
    
    
    render action: :explanation
  end
  
  private
  
  
  
  
  def level_params
    params.require(:studysets).permit()
  end
  
  def setting_params(params)
    
  end

  def get_problems_id(level)
    Qustion.where(level: level).pluck(:id)
  end
  
end
