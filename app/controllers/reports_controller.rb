class ReportsController < ApplicationController
  def index
    @name_hours = name_duration()
  end

  def pick_week
    mondays = cutoffs()
    @monday_strings = mondays.map {|monday| stringify_date monday}
  end

  def report_week
    week_index = params[:week].to_i

    mondays = cutoffs()
    @start_day = stringify_date mondays[week_index]
    @end_day = stringify_date (mondays[week_index] + 6.days)
    @name_hours = name_duration mondays[week_index]
  end

  def refresh
    Task.all.destroy_all
    Entry.all.destroy_all
    Project.all.destroy_all

    data_sources = ['/Users/yujason2/Dropbox/Apps/JiffyBackup/2013.csv',
                    '/Users/yujason2/Dropbox/Apps/JiffyBackup/jiffy.csv']
    data_sources.each { |source| Entry.parse_entries source }

    redirect_to action: :index, notice: "Successfully refreshed data!"
  end

  private
  def stringify_date(date)
    date.strftime('%A, %B %e, %Y')
  end
  # list of date objects that are cutoff points for a week's worth of data.
  # I chose monday
  def cutoffs
    entries = Entry.all.order('start_time ASC')
    first_cutoff = entries.find {|entry| entry.start_time.to_date.monday?}.start_time.to_date
    last_cutoff = entries.reverse.find {|entry| entry.start_time.to_date.monday?}.start_time.to_date

    cutoff = first_cutoff
    cutoffs = []
    while cutoff < last_cutoff
      cutoffs << cutoff.dup
      cutoff += 1.week
    end

    return cutoffs
  end

  # calculates a list of hashes with {project_name: duration} for the
  # given week. If no day_of_week is passed, then it's calculated for all data.
  def name_duration(day_of_week=nil)
    # hash of project_name to hours spent
    project_names = Project.all.map(&:name)
    name_hours = {}
    project_names.each do |name|
      name_hours[name] = 0
    end
    if day_of_week
      entries = Entry.where("start_time > ? AND stop_time < ?", day_of_week, day_of_week + 7.days)
    else
      entries = Entry.all 
    end

    entries.each do |entry|
      project = entry.project
      name_hours[project.name] += entry.duration
    end

    # Round to nearest hundredth
    name_hours.each do |name, hours|
      name_hours[name] = (hours*100).round/100.0
    end

    return name_hours
  end
end
