class ReaddNewIndexToQuestion < ActiveRecord::Migration[5.2]
  def change
    remove_index :questions, column: [:kanji, :ex_top, :ex_bottom, :level]
    add_index :questions, [:kanji, :ex_top, :level, :category], unique: true
  end
end
