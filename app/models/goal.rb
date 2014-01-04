class Goal < ActiveRecord::Base
  def goal_type_string
    self.goal_type > 0 ? "Positive" : "Negative"
  end

  def owner_name
  end
end