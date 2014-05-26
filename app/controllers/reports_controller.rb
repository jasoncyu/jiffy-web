class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)

    respond_to do |format|
      begin
        if @report.save
          refresh_all_data(@report.jiffy_summary.current_path)
          format.html { redirect_to @report, notice: 'Report was successfully created.' }
          format.json { render action: 'show', status: :created, location: @report }
        else
          format.html { render action: 'new' }
          format.json { render json: @report.errors, status: :unprocessable_entity }
        end
      rescue Exception => e
        format.html {redirect_to @report, notice: "#{e.class}: #{e.message}"}
      end
    end
  end

  def refresh_all_data(jiffy_summary_path)
    delete_current_data!
    Entry.read_new_data(jiffy_summary_path)
    Goal.relink_goals

    # redirect_to weeks_path, notice: "Data updated"
    # render nothing: true
  end

  def delete_current_data!
    Task.destroy_all
    Entry.destroy_all
    Project.destroy_all
    # Week.destroy_all
    # Goal.destroy_all
  end


  private
    def report_params
      params.require(:report).permit!
    end
end
