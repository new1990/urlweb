class AddFolder < ActiveRecord::Migration[5.2]
  def change
    add_column :folders, :favicon, :string
  end
end
