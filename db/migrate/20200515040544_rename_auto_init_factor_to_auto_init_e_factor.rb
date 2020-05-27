class RenameAutoInitFactorToAutoInitEFactor < ActiveRecord::Migration[5.2]
  def change
    rename_column :settings, :auto_init_factor, :auto_init_e_factor
  end
end
