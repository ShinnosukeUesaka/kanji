class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.date :kanken_day
      t.integer :kanken_level

      t.timestamps
    end
  end
end
