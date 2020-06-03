class DatedevController < ApplicationController
  require 'date'
  
  def progress_oneday
    require 'rake'
    Datedev.take.update(today: Datedev.take.today + 1)
    
    #https://qiita.com/chatora_mikan/items/fda23646a37b91ac1716
    Rails.application.load_tasks
    Rake::Task['update_progresses:active_users'].execute
    Rake::Task['update_progresses:active_users'].clear
    
    redirect_back(fallback_location: root_path) #jsを使って画面遷移しない方法を実装する。
  end
  
end
