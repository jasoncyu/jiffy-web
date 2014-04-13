class AddGoalRelinkingToGoals < ActiveRecord::Migration
  def change
    # Specifies if goal belongs to a project or a task
    add_column :goals, :owner_type, :integer
    # The name of the project or task that's the owner. 
    add_column :goals, :owner_name, :string
  end
end
