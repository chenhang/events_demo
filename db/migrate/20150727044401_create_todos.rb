class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.string :content
      t.date :due
      t.integer :creator_id
      t.integer :doer_id
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
