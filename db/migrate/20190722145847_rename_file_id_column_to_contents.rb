class RenameFileIdColumnToContents < ActiveRecord::Migration[5.2]
  def change
    rename_column :contents, :file_id, :folder_id
  end
end
