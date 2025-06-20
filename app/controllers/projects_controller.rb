class ProjectsController < ApplicationController
  include ActionController::Flash
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
      flash[:notice] = "Project created successfully."
      render json: @project, status: :created
    else
      flash.now[:alert] = "Error creating project."
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
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Project not found."
    redirect_to projects_path
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = "Project updated successfully."
      render json: @project, status: :ok
    else
      flash.now[:alert] = "Error updating project."
      render json: @project.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Project not found."
    redirect_to projects_path
  end

  def show
  end

  def destroy
    if @project.destroy
      flash[:notice] = "Project deleted successfully."
      render json: { message: "Project deleted successfully." }, status: :ok
    else
      flash.now[:alert] = "Error deleting project."
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :pattern_name, :pattern_source, :designer, :craft, :tool_size, :yardage, :weight, :user_id)
  end

  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Project not found."
    redirect_to projects_path
  rescue StandardError => e
    flash[:alert] = "An error occurred: #{e.message}"
    redirect_to projects_path
  rescue Exception => e
    flash[:alert] = "An unexpected error occurred: #{e.message}"
    redirect_to projects_path
  rescue => e
    flash[:alert] = "An error occurred: #{e.message}"
    redirect_to projects_path
  end
end
