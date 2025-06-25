class YarnsController < ApplicationController
  include ApplicationHelper

  before_action :set_yarn, except: [ :index, :create ]

  def index
    @yarns = Yarn.all
    sort_order = set_order_from_params(params: params, default_attribute: 'colorway')
    @yarns = @yarns.order(sort_order)
    render json: @yarns
  end

  def create
    @yarn = current_user.yarns.new(yarn_params) if current_user  # Create yarn associated with the current user

    if @yarn.save!
      if params[:project_id].present?
        @project = Project.find(params[:project_id])
        @project_yarn = @yarn.project_yarns.create!(project: @project) if @project  # Associate yarn with the project if provided
      end
    end
    render json: @yarn
  end

  def update
    @yarn.update!(yarn_params)
    render json: @yarn
  end

  # to order the projects a specific way, send object under projects
  def show
    @projects = @yarn.projects
    @projects = @projects.includes(:yarns) if @projects.any?  # Eager load yarns for projects to avoid N+1 queries
    @projects = @projects.order(set_order_from_params(params: params[:projects], default_attribute: 'title'))

    render json: {
      yarn: @yarn,
      projects: @projects
    }, status: :ok
  end

  def destroy
    @yarn.destroy!
  end

  private

  def yarn_params
    params.require(:yarn).permit(:brand_name, :colorway, :fiber, :weight, :yardage, :quantity, :user_id)
  end

  def set_yarn
    @yarn = Yarn.find(params[:id])
  end
end
