class Goal < ActiveRecord::Base
  def goal_type_string
    self.is_positive ? "Positive" : "Negative"
  end

  def is_positive?
    self.goal_type > 0
  end

  def is_negative?
    self.goal_type < 0
  end

  def owner_name
    if @goal_type == 'ProjectGoal'
      @project
    elsif @goal_type == 'TaskGoal'
      @task
    end
  end
end