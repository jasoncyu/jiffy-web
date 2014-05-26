class WeeksController < ApplicationController
  include ApplicationHelper

  def index
    @weeks = Week.all
  end

  def show
    @week = Week.find(params[:id])
    gon.project_names = @week.projects.map(&:name)
    gon.actual_data = @week.projects.map { |p| @week.project_data[p.id]["hours"] }
    gon.pos_goal_data = @week.projects.map {|p| (p.goal and p.goal.is_positive?) ? p.goal.amount : 0}
    gon.neg_goal_data = @week.projects.map {|p| (p.goal and p.goal.is_negative?) ? p.goal.amount : 0}
  end
end
