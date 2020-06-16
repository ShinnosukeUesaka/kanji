class RenameEfactor < ActiveRecord::Migration[5.2]
  def change
    rename_column :progresses, :e_factor, :efactor
  end
end
