class CreateMBaitais < ActiveRecord::Migration[5.2]
  def change
    create_table :m_baitais do |t|

      t.timestamps
    end
  end
end
