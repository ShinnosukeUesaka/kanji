class CreateDatedev < ActiveRecord::Migration[5.2]
  def change
    create_table :datedevs do |t|
      t.date :today
    end
  end
end
