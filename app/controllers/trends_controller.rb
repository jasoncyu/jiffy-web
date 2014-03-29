class TrendsController < ApplicationController
  def compare
    @projects = Project.all
    @weeks = Week.all

    gon.jbuilder "app/views/weeks/index.json", as: "weeks"
    gon.jbuilder "app/views/projects/index.json", as: "projects"
  end
end
