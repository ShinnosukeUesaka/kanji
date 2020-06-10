# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'date'

(1..50).each do |number|
    (0..11).each do |level|
        unique_num = number.to_s + level.to_s
        Question.create(level: level, category: 0, kanji: "熟達" + unique_num , yomi: "ジュクタツ" + unique_num, meaning: "慣れて上手になること。" + unique_num, ex_top: "物事に" + unique_num,ex_bottom: "するには長い年月が必要だ。" + unique_num)
        Question.create(level: level, category: 1, kanji: "熟達" + unique_num , yomi: "ジュクタツ" + unique_num, meaning: "慣れて上手になること。" + unique_num, ex_top: "物事に" + unique_num,ex_bottom: "するには長い年月が必要だ。" + unique_num)
        Question.create(level: level, category: 2, kanji: "正真正銘" + unique_num , yomi: "ショウシンショウメイ" + unique_num, meaning: "嘘や偽りのないこと" + unique_num, ex_top: "" + unique_num,ex_bottom: "まぎれれもない水だった。" + unique_num)
    end
end

Datedev.create(today: Date.today)

#User.create(name: 'test', email: 'test@gmail.com', password: 'test', age: 0, usertype: 0)
