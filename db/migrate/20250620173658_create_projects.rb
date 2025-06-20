class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :pattern_name
      t.string :pattern_source
      t.string :designer
      t.string :craft
      t.string :tool_size
      t.integer :yardage
      t.string :weight
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
