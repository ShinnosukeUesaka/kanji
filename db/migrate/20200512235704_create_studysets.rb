class CreateStudysets < ActiveRecord::Migration[5.2]
  def change
    create_table :studysets do |t|
      t.references :user, foreign_key: true
      t.date :study_began_on
      t.boolean :active
      t.integer :level
      t.boolean :kaki_active
      t.boolean :yomi_active
      t.boolean :yoji_active

      t.timestamps
    end
  end
end
