class RemoveProjectIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :project_id, :integer
  end
end
