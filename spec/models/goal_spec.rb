require 'spec_helper'

describe Goal do
  describe "creation" do
    before do
      @project = Project.new name: "project"
      @task = Task.new name: "task"
      @task_goal = TaskGoal.new
      @task_goal.owner_name = 
    end 
end
