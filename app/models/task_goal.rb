class TaskGoal < Goal
  belongs_to :task

  def owner_name
    Task.find(self.task_id).name 
  end
end
