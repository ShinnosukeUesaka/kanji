class AddActiveTodayToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :active_today, :boolean
  end
end
