class AddColumnsToFolders < ActiveRecord::Migration[5.2]
  def change
    add_column :folders, :manage_folders_id, :integer
  end
end
