class CreateYarns < ActiveRecord::Migration[8.0]
  def change
    create_table :yarns do |t|
      t.string :brand_name
      t.string :colorway
      t.string :fiber
      t.string :weight
      t.integer :yardage
      t.integer :quantity
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
