module UsertopHelper
    def pi_selector
     str =  '<select id="piSelect" onchange="myFunction()"><option value="">すべて' 
     levels = current_user.studysets.pluck(:level)
     levels.each do |level|
         str = str + "<option value='#{level}'>'#{User.kanken_levels_i18n[User.kanken_levels.invert[level]]}'"
    end
     str = str + '</select>'
              
    str.html_safe
    end
end
