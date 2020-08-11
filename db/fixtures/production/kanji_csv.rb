require 'csv'



CSV.foreach('db/fixtures/kanji.csv', encoding: "Shift_jis:UTF-8", headers: true) do |row|

  Question.seed do |s|
     s.category = row['category']
     s.ex_top = row['ex_top']
     s.kanji = row['kanji']
     s.ex_bottom = row['ex_bottom']
     s.yomi = row['yomi']
     s.level = row['level']
  end
end
