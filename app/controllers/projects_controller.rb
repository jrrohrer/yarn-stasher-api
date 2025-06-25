class ProjectsController < ApplicationController
  include ApplicationHelper

  before_action :set_project, except: [ :index, :create ]

  def index
    @projects = Project.all
    @projects = @projects.order(set_order_from_params(params: params, default_attribute: 'title'))
    render json: @projects
  end

  def create
    @project = Project.create!(project_params)
    render json: @project
  end

  def update
    @project.update!(project_params)
    render json: @project
  end

  # to order the yarns a specific way, send object under yarns
  def show
    @yarns = @project.yarns
    @yarns = @yarns.includes(:projects) if @yarns.any?  # Eager load projects for yarns to avoid N+1 queries
    @yarns = @yarns.order(set_order_from_params(params: params[:yarns], default_attribute: 'colorway'))
    render json: {
      project: @project,
      yarns: @yarns
    }, status: :ok
  end

  def destroy
    @project.destroy
  end

  private

  def project_params
    params.require(:project).permit(:title, :pattern_name, :pattern_source, :designer, :craft, :tool_size, :yardage, :weight, :user_id)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
