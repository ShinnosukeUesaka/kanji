class AddNewIndexToQuestion < ActiveRecord::Migration[5.2]
  def change
    remove_index :questions, column: [:kanji, :ex_top, :ex_bottom]
    add_index :questions, [:kanji, :ex_top, :ex_bottom, :level], unique: true
  end
end
