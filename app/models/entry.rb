require 'csv'
# 2013.csv has all the 2013 records
# jiffy.csv has the latest records
class Entry < ActiveRecord::Base
  include Comparable

  validates :start_time, uniqueness: true, presence: true
  validates :stop_time, uniqueness: true, presence: true
  validates :hours, presence: true
  validates :minutes, presence: true

  belongs_to :project
  belongs_to :task
  has_and_belongs_to_many :weeks

  # attr_accessor :start_time, :stop_time, :task_id, :project_id, :hours, :minutes, :note

  def duration
    hours + minutes.to_f/60
  end

  # pretty prints either start time or stop time
  def pretty(key)
    self.send(key.to_sym).strftime("%m-%d-%Y %k:%M")
  end

  # entry starts on one day and ends on another
  def spans_two_days?
    self.start_time.to_date != self.stop_time.to_date
  end

  #if spans_two_days?, then returns [duration_today, duration_tomorrow]
  def split_duration
    # tomorrow at 00:00
    tomorrow = self.tomorrow
    duration_today = (tomorrow - self.start_time).to_f / 3600
    duration_tomorrow = (self.stop_time - tomorrow).to_f / 3600

    [duration_today, duration_tomorrow]
  end

  def starts_in_week?(week)
    (week.start_day <= self.start_time) and (self.start_time <= week.start_day + 7.days)
  end

  # returns the amount of time that an entry spent in the given week.
  def duration_for_week(week)
    return duration unless spans_two_days?

    ret = 0
    if week.contains_day?(self.start_time.to_date)
      ret += self.split_duration[0]
    end

    if week.contains_day?(self.stop_time.to_date)
      ret += self.split_duration[1]
    end

    return ret
  end

  # returns the next day at midnight
  def tomorrow
    tomorrow = (self.start_time + 1.day)
    Time.utc(tomorrow.year, tomorrow.month, tomorrow.day)
  end

  #returns duplicates if there are any, else empty
  def self.dup_entries
    Entry.all.select {|e| !e.valid?}
  end

  def self.read_new_data(jiffy_summary_path)
    # self.column_names = "Customer,Project,Task,Start time,Stop time,Minutes,Note".split(',')
    column_names_row = true
    CSV.foreach(jiffy_summary_path) do |row|
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
      entry.note = note

      entry.save
    end

    Week.create_weeks
  end


end
