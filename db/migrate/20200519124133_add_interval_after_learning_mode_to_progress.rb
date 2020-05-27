class AddIntervalAfterLearningModeToProgress < ActiveRecord::Migration[5.2]
  def change
    add_column :progresses, :interval_after_learning_mode, :integer
  end
end
