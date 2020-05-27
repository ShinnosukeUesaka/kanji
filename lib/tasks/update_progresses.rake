namespace :update_progresses do
  #https://qiita.com/hirotakasasaki/items/3b31966294a809b99c4c
  #https://qiita.com/kyohei8/items/5a7d7db3838728a04140
  desc "update progresses(usually run everynight)"
  task :active_users => :environment do
    User.where(active_today: true) do |user|
      user.update_progresses
      user.update_attribute(active_true: false)
    end
  end
  task :all_users => :environment do
    User.all.update_progresses do |user|
      user.update_progresses
      user.update_attribute(active_true: false)
    end
  end
end
