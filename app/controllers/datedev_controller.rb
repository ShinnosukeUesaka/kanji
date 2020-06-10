class DatedevController < ApplicationController
  require 'date'
  
  def progress_oneday
    require 'rake'
    Datedev.take.update(today: Datedev.take.today + 1)
    
    #なぜか動かない。。
    # app = Rake.application
    # app.init
    # # do this as many times as needed
    # app.add_import 'lib/tasks/update_progresses.rake'
    # # this loads the Rakefile and other imports
    # app.load_rakefile
    
    # app['update_progresses:active_users'].invoke()
    
     User.where(active_today: true).each do |user|
      user.update_progresses
      user.update_attribute(:active_today, false)
      puts user.active_today
    end
    
    redirect_back(fallback_location: root_path) #jsを使って画面遷移しない方法を実装する。
  end
  
end
