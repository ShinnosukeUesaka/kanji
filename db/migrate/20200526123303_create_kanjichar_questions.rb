class CreateKanjicharQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :kanjichar_questions do |t|
      t.references :kanjichar, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
