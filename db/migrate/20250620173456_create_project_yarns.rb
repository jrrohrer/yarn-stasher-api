class CreateProjectYarns < ActiveRecord::Migration[8.0]
  def change
    create_table :project_yarns do |t|
      t.references :yarn, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.timestamps
    end
  end
end
