class AddDeleteAtToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :delete_at, :datetime
  end
end
