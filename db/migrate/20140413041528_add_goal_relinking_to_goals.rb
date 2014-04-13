class AddGoalRelinkingToGoals < ActiveRecord::Migration
  def change
    # Specifies if goal belongs to a project or a task
    add_column :goals, :owner_type, :integer
  end
end
