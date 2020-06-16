class RenameLastDueDateToPreviousAnswerDay < ActiveRecord::Migration[5.2]
  def change
    rename_column :progresses, :previous_due_date, :previous_answered_date
  end
end
