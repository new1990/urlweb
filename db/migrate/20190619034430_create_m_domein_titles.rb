class CreateMDomeinTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :m_domein_titles do |t|
      t.string :domein
      t.string :title
      t.timestamps
    end
  end
end
