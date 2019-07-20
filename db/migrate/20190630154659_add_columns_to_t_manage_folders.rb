class AddColumnsToTManageFolders < ActiveRecord::Migration[5.2]
  def change
    add_column :t_manage_folders, :manage_folders_id, :integer
  end
end
