class ReportsController < ApplicationController
  def index
    # hash of project_name to hours spent
    project_names = Project.all.map(&:name)
    @name_hours = {}
    project_names.each do |name|
      @name_hours[name] = 0
    end

    Entry.all.each do |entry|
      project = entry.project
      @name_hours[project.name] += entry.duration
    end

    # Round to nearest hundredth
    @name_hours.each do |name, hours|
      @name_hours[name] = (hours*100).round/100.0
    end
  end
end
