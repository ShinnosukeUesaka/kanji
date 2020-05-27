class RenameBottumToBottom < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :ex_buttom, :ex_bottom
  end
end
