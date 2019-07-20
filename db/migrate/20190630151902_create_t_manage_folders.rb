class CreateTManageFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :t_manage_folders do |t|
      t.integer :user_id
      t.string :manage_folder_name

      t.timestamps
    end
  end
end
