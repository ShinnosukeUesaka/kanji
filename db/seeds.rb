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
        Question.create(level: level, category: 0, kanji: "漢字(書き)" + unique_num , yomi: "読み(書き)" + unique_num, meaning: "意味(書き)" + unique_num, ex_top: "例文前(書き)。。。。。" + unique_num,ex_bottom: "例文後(書き)。。。。。。。" + unique_num)
        Question.create(level: level, category: 1, kanji: "漢字(読み)" + unique_num, yomi: "読み(読み)", meaning: "意味(読み)" + unique_num, ex_top: "例文前(読み)。。。。。" + unique_num,ex_bottom: "例文後(読み)。。。。。。。" + unique_num)
        Question.create(level: level, category: 2, kanji: "漢字(四字熟語)" + unique_num, yomi: "読み(四字熟語)" + unique_num, meaning: "意味(四字熟語)" + unique_num, ex_top: "例文前。。。。。(四字熟語)" + unique_num,ex_bottom: "例文後(四字熟語)。。。。。。。" + unique_num)
    end
end

Datedev.create(today: Date.today)

#User.create(name: 'test', email: 'test@gmail.com', password: 'test', age: 0, usertype: 0)
