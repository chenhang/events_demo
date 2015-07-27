class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.integer :eventable_id
      t.string :eventable_type
      t.string :action
      t.text :content

      t.timestamps null: false
    end
  end
end
