require 'csv'

class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
    if params[:week_id]
      week = Week.find(params[:week_id])
      date_entries = week.entries.group_by {|e| e.start_time.to_date}
      @date_entries = Hash[date_entries.map{|date, entries| [date, entries]}.sort_by(&:first)]
    end

    @date_format = "%m-%d-%Y"
  end

  def filter_by_project
    week = Week.find params[:week_id].to_i
    @week_id = params[:week_id]
    @project_id = params[:project_id]
    if params[:project_id]
      @entries = week.entries.where project_id: params[:project_id].to_i
      date_entries = @entries.group_by {|e| e.start_time.to_date}
      @date_entries = Hash[date_entries.map{|date, entries| [date, entries]}.sort_by(&:first)]
    else
      debug "Error"
    end
    @date_format = "%m-%d-%Y"
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params[:entry]
    end

end
