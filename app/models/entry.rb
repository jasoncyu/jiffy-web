# 2013.csv has all the 2013 records
# jiffy.csv has the latest records
class Entry < ActiveRecord::Base
  include Comparable
  belongs_to :project
  belongs_to :task
  dir_name = '/Users/yujason2/Dropbox/Apps/JiffyBackup/2013.csv'

  # attr_accessor :start_time, :stop_time, :task_id, :project_id, :hours, :minutes, :note
  def duration
    hours + minutes.to_f/60
  end
  
  def self.parse_entries(file_name)
    # self.column_names = "Customer,Project,Task,Start time,Stop time,Minutes,Note".split(',')
    column_names_row = true
    CSV.foreach(file_name) do |row|
      # First row has column names
      if column_names_row
        column_names_row = false
        next
      end

      project_name, task_name, start_time, stop_time, duration_in_minutes, note = row.values_at(1,2,3,4,5,6)

      project = Project.find_by_name(project_name) 
      if !project
        project = Project.create(name: project_name)
      end

      task = Task.find_by_name(task_name) 
      if !task
        task = Task.create(name: task_name)
      end

      date_format = '%Y-%m-%d %H:%M:%S'
      potential_start_time = DateTime.strptime(start_time, date_format)

      entry = Entry.new
      entry.start_time = DateTime.strptime(start_time, date_format)
      entry.stop_time = DateTime.strptime(stop_time, date_format)
      entry.hours = duration_in_minutes.to_i.div(60)
      entry.minutes = duration_in_minutes.to_i % 60
      entry.task_id = task.id
      entry.project_id = project.id

      entry.save!
    end
  end
end
