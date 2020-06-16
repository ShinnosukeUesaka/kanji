class AddMoreProgressSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :max_interval, :integer
  end
end
