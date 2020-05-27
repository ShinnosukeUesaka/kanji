class CreateKanjichars < ActiveRecord::Migration[5.2]
  def change
    create_table :kanjichars do |t|
      t.string :kanji
      t.integer :level

      t.timestamps
    end
  end
end
