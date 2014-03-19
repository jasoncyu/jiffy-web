class ProjectGoal < Goal
  belongs_to :project

  def owner
    @project
  end

  def owner=(owner)
    @project = owner
  end

end
