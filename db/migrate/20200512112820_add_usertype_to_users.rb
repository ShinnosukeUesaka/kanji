class AddUsertypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :usertype, :integer
  end
end
