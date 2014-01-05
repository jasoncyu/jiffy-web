class ReportsController < ApplicationController
  def index
    @name_hours = project_duration()
  end

  #Overall reporting
  def pick_week
    mondays = cutoffs()
    @monday_strings = mondays.map {|monday| stringify_date monday}
  end

  def report_week
    week_index = params[:week].to_i

    mondays = cutoffs()
    @start_day = stringify_date mondays[week_index]
    @end_day = stringify_date (mondays[week_index] + 6.days)
    @name_hours = project_duration week_index

    gon.asdf = 'jason'
  end

  #Project-level reports
  def project_level_pick_week
    mondays = cutoffs()
    @monday_strings = mondays.map {|monday| stringify_date monday}
    @projects = Project.all
  end

  def report_project_week
    week_index = params[:week].to_i

    @project = Project.find(params[:id])
    mondays = cutoffs()
    @start_day = stringify_date mondays[week_index]
    @end_day = stringify_date (mondays[week_index] + 6.days)
    @name_hours = task_duration(@project, mondays[week_index])
  end


  def refresh
    Task.all.destroy_all
    Entry.all.destroy_all
    Project.all.destroy_all
    Goal.all.destroy_all

    data_sources = ['/Users/yujason2/Dropbox/Apps/JiffyBackup/2013.csv',
                    '/Users/yujason2/Dropbox/Apps/JiffyBackup/jiffy.csv']
    data_sources.each { |source| Entry.parse_entries source }

    redirect_to action: :index
  end

  private
  def stringify_date(date)
    date.strftime('%A, %B %e, %Y')
  end
  


  def task_duration(project, week)
    day_of_week = cutoffs()[week]
    task_names = project.tasks.map(&:name)
    task_hours = {no_task: 0}
    task_names.each do |name|
      task_hours[name] = 0
    end

    entries = Entry.where("start_time > ? AND stop_time < ?", day_of_week, day_of_week + 7.days)
    entries = Entry.where(project_id: project.id)

    entries.each do |entry|
      if entry.task
        task_hours[entry.task.name] += entry.duration
      else
        task_hours[:no_task] += entry.duration
      end
    end

    # Round to nearest hundredth
    task_hours.each do |name, hours|
      task_hours[name] = (hours*100).round/100.0
    end
    
    task_hours
  end

end
