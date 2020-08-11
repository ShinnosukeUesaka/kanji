require 'date'
Datedev.seed_once do |s|
  s.today = Date.today
end

User.seed_once do |s|
  s.name = 'test' 
  s.email = 'test@gmail.com'
  s.password = 'test'
  s.age = 0
  s.usertype = 0
  s.active_today = false
end
