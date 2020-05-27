class AddIndexToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_index :questions, [:kanji, :ex_top, :ex_bottom], unique: true
  end
end
