class AddDueDate < ActiveRecord::Migration[5.2]
  def change
    remove_column :progresses, :intervals
    add_column :progresses, :due_date, :date
    add_column :progresses, :previous_due_date, :date
  end
end
