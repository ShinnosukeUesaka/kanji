class Kanjichar < ApplicationRecord
    has_many :kanjichar_questions
    has_many :questions, through: kanjichar_questions
end
