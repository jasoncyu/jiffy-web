class TaskGoal < Goal
  belongs_to :task

  def owner
    @task
  end

  def owner=(owner)
    @task = owner
  end
end
