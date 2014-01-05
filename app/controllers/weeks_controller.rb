class WeeksController < ApplicationController
  include ApplicationHelper

  def index
    @weeks = Week.all
  end

  def show
    @week = Week.find(params[:id])
    gon.project_names = @week.projects.map(&:name)
    gon.actual_data = @week.projects.map { |p| @week.project_data[p.name] }
    gon.pos_goal_data = @week.projects.map {|p| (p.goal and p.goal.is_positive?) ? p.goal.amount : 0}
    gon.neg_goal_data = @week.projects.map {|p| (p.goal and p.goal.is_negative?) ? p.goal.amount : 0}
  end

  def update_data
    parse_entries('/Users/yujason2/Dropbox/Apps/JiffyBackup/jiffy.csv')
    redirect_to weeks_path, notice: "Data updated"
  end
end
