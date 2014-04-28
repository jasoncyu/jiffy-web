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

  def refresh_all_data
    delete_current_data!
    Entry.read_new_data
    Goal.relink_goals

    # redirect_to weeks_path, notice: "Data updated"
    render nothing: true
  end

  def delete_current_data!
    Task.destroy_all
    Entry.destroy_all
    Project.destroy_all
    # Week.destroy_all
    # Goal.destroy_all
  end

end
