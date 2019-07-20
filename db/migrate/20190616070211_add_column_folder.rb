class AddColumnFolder < ActiveRecord::Migration[5.2]
  def change
    add_column :folders, :name, :string
    add_column :folders, :domein, :string
    add_column :folders, :stutas_flg, :integer

  end
end
