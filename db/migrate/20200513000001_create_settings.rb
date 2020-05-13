class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.references :user, foreign_key: true
      t.integer :init_e_factor
      t.boolean :auto_init_factor
      t.string :first_intervals
      t.integer :max_new_questions
      t.integer :max_total_questions

      t.timestamps
    end
  end
end
