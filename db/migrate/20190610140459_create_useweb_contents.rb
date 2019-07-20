class CreateUsewebContents < ActiveRecord::Migration[5.2]
  def change
    create_table :useweb_contents do |t|

      t.timestamps
    end
  end
end
