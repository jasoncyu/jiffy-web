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

  def refresh_all_data
    delete_current_data!
    read_new_data

    redirect_to weeks_path, notice: "Data updated"
  end

  def delete_current_data!
    Task.all.destroy_all
    Entry.all.destroy_all
    Project.all.destroy_all
    # Week.all.destroy_all
    # Goal.all.destroy_all
  end

  def read_new_data
    # self.column_names = "Customer,Project,Task,Start time,Stop time,Minutes,Note".split(',')
    column_names_row = true
    CSV.foreach(ApplicationHelper::JIFFY_CSV_PATH) do |row|
      # First row has column names
      if column_names_row
        column_names_row = false
        next
      end

      project_name, task_name, start_time, stop_time, duration_in_minutes, note = row.values_at(1,2,3,4,5,6)

      entry = Entry.new

      project = Project.find_by_name(project_name) 
      if !project
        project = Project.create(name: project_name)
      end
      entry.project_id = project.id

      if task_name
        task = Task.find_by_name(task_name) 
        if !task
          task = Task.create(name: task_name)
          project.tasks << task
        end
      entry.task_id = task.id
      end

      date_format = '%Y-%m-%d %H:%M:%S'
      potential_start_time = DateTime.strptime(start_time, date_format)

      entry.start_time = DateTime.strptime(start_time, date_format)
      entry.stop_time = DateTime.strptime(stop_time, date_format)
      entry.hours = duration_in_minutes.to_i.div(60)
      entry.minutes = duration_in_minutes.to_i % 60

      entry.save
    end

    Week.create_weeks
  end
end
