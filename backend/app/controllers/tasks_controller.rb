class TasksController < ApplicationController
  include Authenticatable

  before_action :set_task, only: [:show, :update, :destroy]
  before_action :authorize_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = if params[:project_id]
               Project.find(params[:project_id]).tasks
             else
               current_user.tasks
             end
    
    @tasks = @tasks.by_status(params[:status]) if params[:status]
    @tasks = @tasks.overdue if params[:overdue] == 'true'
    @tasks = @tasks.due_soon if params[:due_soon] == 'true'
    @tasks = @tasks.recent

    render json: @tasks, each_serializer: TaskSerializer, status: :ok
  end

  # GET /tasks/:id
  def show
    render json: @task, serializer: TaskSerializer, status: :ok
  end

  # POST /tasks
  def create
    @task = current_user.tasks.build(task_params)
    @task.project_id = params[:project_id] if params[:project_id]
    
    if @task.save
      render json: {
        message: 'Task created successfully',
        task: TaskSerializer.new(@task)
      }, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/:id
  def update
    if @task.update(task_params)
      render json: {
        message: 'Task updated successfully',
        task: TaskSerializer.new(@task)
      }, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/:id
  def destroy
    if @task.destroy
      render json: { message: 'Task deleted successfully' }, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /tasks/:id/status
  def update_status
    if @task.update(status: params[:status])
      render json: {
        message: 'Task status updated successfully',
        task: TaskSerializer.new(@task)
      }, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date, :project_id)
  end

  def authorize_task
    unless current_user.admin? || @task.user == current_user
      render json: { error: 'Not authorized' }, status: :forbidden
    end
  end
end


