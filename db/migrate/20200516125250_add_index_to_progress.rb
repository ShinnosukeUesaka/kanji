class AddIndexToProgress < ActiveRecord::Migration[5.2]
  def change
    add_index :progresses, [:user_id, :question_id], unique: true
  end
end
