class CreateProgresses < ActiveRecord::Migration[5.2]
  def change
    create_table :progresses do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.boolean :active
      t.integer :category
      t.boolean :learning_mode
      t.integer :learning_mode_n
      t.integer :e_factor
      t.string :intervals
      t.boolean :is_due

      t.timestamps
    end
  end
end
