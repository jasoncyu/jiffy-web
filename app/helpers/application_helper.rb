module ApplicationHelper
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def parse_entries(file_name)
    # self.column_names = "Customer,Project,Task,Start time,Stop time,Minutes,Note".split(',')
    column_names_row = true
    CSV.foreach(file_name) do |row|
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

      entry.save!
    end
  end
end
