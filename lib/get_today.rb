module GetToday
  #TODO: 国ごとの時刻取得
  require 'date'
  def get_today
    if Rails.env.development?
        return Datedev.getdate
    else
        return Date.today
    end
  end
end