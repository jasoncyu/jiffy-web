class TrendsController < ApplicationController
  def compare
    @projects = Project.all
    @weeks = Week.all

    gon.jbuilder "app/views/weeks/index.json", as: "weeks"
  end
end
