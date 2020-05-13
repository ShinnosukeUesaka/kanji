class AddUsertypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :Usertype, :integer
  end
end
