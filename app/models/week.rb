class Week < ActiveRecord::Base
  has_many :entries

  # calculates a list of hashes with {project_name: duration} for this week's entries
  def project_data
    # hash of project_name to hours spent
    h = Hash.new 0

    entries.each do |entry|
      project = entry.project
      h[project.name] += entry.duration
    end

    # Round to nearest hundredth
    h.each do |name, hours|
      h[name] = hours.round(2)
    end

    return h
  end

  def projects
    entries.map(&:project).uniq
  end

  # calculates a list of hashes with {task_name: duration} for this week's entries
  def task_data
    h = Hash.new 0

    entries.each do |entry|
      h[entry.task.name] += entry.duration if entry.task
    end

    # Round to nearest hundredth
    h.each do |name, hours|
      h[name] = hours.round(2)
    end

    return h
  end

  def self.create_weeks
    entries = Entry.all.order('start_time ASC')
    mondays.each do |monday|
      entries = Entry.where("start_time > ? AND stop_time < ?", monday, monday + 7.days)
      Week.create(start_day: monday, entries: entries)
    end
  end

  # array of mondays that are covered by the entries
  def self.mondays
    entries = Entry.all.order('start_time ASC')
    first_monday = entries.find {|entry| entry.start_time.to_date.monday?}.start_time.to_date
    last_monday = entries.reverse.find {|entry| entry.start_time.to_date.monday?}.start_time.to_date

    monday = first_monday
    mondays = []
    while monday <= last_monday
      mondays << monday.dup
      monday += 1.week
    end

    return mondays
  end


end
