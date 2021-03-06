class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :creator_id
      t.text :content
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps null: false
    end
  end
end
