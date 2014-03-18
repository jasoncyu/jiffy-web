class AddGoalIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :goal_id, :integer 
  end
end
