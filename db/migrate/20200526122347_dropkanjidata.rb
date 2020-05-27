class Dropkanjidata < ActiveRecord::Migration[5.2]
  def change
    drop_table :kanjidata_questions
    drop_table :kanjidata
  end
end
