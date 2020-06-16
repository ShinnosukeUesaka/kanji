class RenameEfactorRelated < ActiveRecord::Migration[5.2]
  def change
    rename_column :settings, :init_e_factor, :init_efactor
    rename_column :settings, :auto_init_e_factor, :auto_init_efactor
  end
end
