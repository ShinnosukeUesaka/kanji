class RenameIdDueToShowProgress < ActiveRecord::Migration[5.2]
  def change
    rename_column :progresses, :is_due, :show
  end
end
