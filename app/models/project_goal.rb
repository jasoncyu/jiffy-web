class ProjectGoal < Goal
  belongs_to :project
  def owner_name
    Project.find(self.project_id).name
  end
end
