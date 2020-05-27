class RenameFirstIntervalsSetting < ActiveRecord::Migration[5.2]
  def change
    rename_column :settings, :first_intervals, :learning_mode_intervals
  end
end
