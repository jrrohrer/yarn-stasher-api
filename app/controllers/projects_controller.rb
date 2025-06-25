class ProjectsController < ApplicationController
  include ApplicationHelper

  before_action :set_project, except: [ :index, :create, :new ]

  def index
    @projects = Project.all
    @projects = @projects.order(:name)

    render json: @projects
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def new
    @project = Project.new
    render json: @project, status: :ok
  end

  def edit
    @project = Project.find(params[:id])
    render json: @project, status: :ok
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    if @project.destroy
      render json: { message: "Project deleted successfully." }, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :pattern_name, :pattern_source, :designer, :craft, :tool_size, :yardage, :weight, :user_id)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
