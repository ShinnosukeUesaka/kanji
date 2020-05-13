class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :level
      t.integer :type
      t.string :kanji
      t.string :yomi
      t.string :meaning
      t.string :ex_top
      t.string :ex_buttom

      t.timestamps
    end
  end
end
