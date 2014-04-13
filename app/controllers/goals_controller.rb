class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  # GET /goals
  # GET /goals.json
  def index
    @goals = Goal.all
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
  end

  # GET /goals/new
  def new
    @goal = Goal.new
    @projects = Project.all
    @tasks = @projects.first.tasks
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  # POST /goals.json
  def create

    if params[:goal_owner] == "project"
      @goal = ProjectGoal.new
      @goal.amount = params[:goal][:amount].to_i
      @goal.goal_type = params[:goal_type].to_i
      project = Project.find(params[:project_id])
      project.goal = @goal

      project.owner_type = Goal::PROJECT_TYPE
      project.owner_name = project.name
    else
      @goal = TaskGoal.new
      @goal.amount = params[:goal][:amount].to_i
      @goal.goal_type = params[:goal_type].to_i
      task = Task.find(params[:task_id])
      task.goal = @goal 

      project.owner_type = Goal::TASK_TYPE
      project.owner_name = task.name
    end


    respond_to do |format|
      if @goal.save
        format.html { redirect_to goals_path, notice: 'Goal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @goal }
      else
        format.html { render action: 'new' }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to goals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params[:goal]
    end
end
