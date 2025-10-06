class ProjectsController < ApplicationController
  include Authenticatable

  before_action :set_project, only: [:show, :update, :destroy]
  before_action :authorize_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    @projects = current_user.projects.recent
    render json: @projects, each_serializer: ProjectSerializer, status: :ok
  end

  # GET /projects/:id
  def show
    render json: @project, serializer: ProjectSerializer, status: :ok
  end

  # POST /projects
  def create
    @project = current_user.projects.build(project_params)
    
    if @project.save
      render json: {
        message: 'Project created successfully',
        project: ProjectSerializer.new(@project)
      }, status: :created
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/:id
  def update
    if @project.update(project_params)
      render json: {
        message: 'Project updated successfully',
        project: ProjectSerializer.new(@project)
      }, status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:id
  def destroy
    if @project.destroy
      render json: { message: 'Project deleted successfully' }, status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def authorize_project
    unless current_user.admin? || @project.user == current_user
      render json: { error: 'Not authorized' }, status: :forbidden
    end
  end
end


