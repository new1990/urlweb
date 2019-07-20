class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|

      t.integer :user_id
      t.integer :file_id
      t.integer :status_flg
      t.text :favicon
      t.text :title
      t.text :url
      t.timestamps
    end
  end
end
