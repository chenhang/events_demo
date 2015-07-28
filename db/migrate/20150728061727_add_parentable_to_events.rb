class AddParentableToEvents < ActiveRecord::Migration
  def change
    add_column :events, :parentable_id, :integer
    add_column :events, :parentable_type, :string
  end
end
