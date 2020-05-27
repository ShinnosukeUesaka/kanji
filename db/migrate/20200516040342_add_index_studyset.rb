class AddIndexStudyset < ActiveRecord::Migration[5.2]
  def change
    add_index :studysets, [:user_id, :level], unique: true
  end
end
