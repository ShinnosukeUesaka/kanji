require 'csv'



CSV.foreach('db/fixtures/kanji.csv', encoding: "Shift_jis:UTF-8", headers: true) do |row|
# row -> ["level", "category", "ex_top", "kanji", "ex_bottom", "yomi"]
# row -> ["two", "kaki", "自然豊かで", "酪農", "が盛んだ。", "らくのう"]
# row[0] -> "two"
# row[1] -> "kaki"

  Question.seed do |s|
     s.category = row['category']
     s.ex_top = row['ex_top']
     s.kanji = row['kanji']
     s.ex_bottom = row['ex_bottom']
     s.yomi = row['yomi']
     s.level = row['level']
  end
end
