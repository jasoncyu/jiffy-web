class Goal < ActiveRecord::Base
  PROJECT_TYPE = 0
  TASK_TYPE = 1

  validates :goal_type, presence: true
  validates :amount, presence: true
  validates :owner_type, presence: true
  validates :owner_name, presence: true

  def goal_type_string
    self.is_positive? ? "Positive" : "Negative"
  end

  def is_positive?
    self.goal_type > 0
  end

  def is_negative?
    self.goal_type < 0
  end


  def self.relink_goals
    owner = nil

    Goal.all.each do |goal|
      if goal.owner_type == Goal::PROJECT_TYPE
        owner = Project.find_by name: goal.owner_name
      elsif goal.owner_type == Goal::TASK_TYPE
        owner = Task.find_by name: goal.owner_name
      end

      if !owner
        logger.debug "Old project/task not found"
      else
        owner.goal = goal
      end
     end

  end
end