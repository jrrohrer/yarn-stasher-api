class YarnsController < ApplicationController
  include ActionController::Flash
  include ApplicationHelper

  before_action :set_yarn, except: [ :index, :create ]

  def index
    @yarns = Yarn.all
    @yarns = @yarns.order(:colorway)
    render json: @yarns
  end

  def create
    @yarn = current_user.yarns.new(yarn_params) if current_user  # Create yarn associated with the current user

    if @yarn.save
      if params[:project_id].present?
        @project = Project.find(params[:project_id])
        @project_yarn = @yarn.project_yarns.new(project: @project) if @project  # Associate yarn with the project if provided
        if @project_yarn.save
          flash[:notice] = "Yarn created and associated with project successfully."
          render json: @yarn, status: :created
        else
          flash[:alert] = "Error associating yarn with project."
          render json: @project_yarn.errors, status: :unprocessable_entity and return
        end

      else
        flash[:notice] = "Yarn created successfully."
        render json: @yarn, status: :created
      end
    else
      flash.now[:alert] = "Error creating yarn."
      render json: @yarn.errors, status: :unprocessable_entity
    end
  end

  def update
    if @yarn.update(yarn_params)
      flash[:notice] = "Yarn updated successfully."
      render json: @yarn, status: :ok
    else
      flash.now[:alert] = "Error updating yarn."
      render json: @yarn.errors, status: :unprocessable_entity
    end
  end

  def show
    @projects = @yarn.projects.order(:name)
    @projects = @projects.includes(:yarns) if @projects.any?  # Eager load yarns for projects to avoid N+1 queries
    render json: {
      yarn: @yarn,
      projects: @projects
    }, status: :ok
  rescue StandardError => e
    flash[:alert] = "An error occurred: #{e.message}"
    redirect_to yarns_path
  rescue Exception => e
    flash[:alert] = "An unexpected error occurred: #{e.message}"
    redirect_to yarns_path
  rescue => e
    flash[:alert] = "An error occurred: #{e.message}"
    redirect_to yarns_path
  end

  def destroy
    if @yarn.destroy
      flash[:notice] = "Yarn deleted successfully."
      render json: { message: "Yarn deleted successfully." }, status: :ok
    else
      flash.now[:alert] = "Error deleting yarn."
      render json: @yarn.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    flash[:alert] = "An error occurred: #{e.message}"
    redirect_to yarns_path
  rescue Exception => e
    flash[:alert] = "An unexpected error occurred: #{e.message}"
    redirect_to yarns_path
  rescue => e
    flash[:alert] = "An error occurred: #{e.message}"
    redirect_to yarns_path
  end

  private

  def yarn_params
    params.require(:yarn).permit(:brand_name, :colorway, :fiber, :weight, :yardage, :quantity, :user_id)
  end

  def set_yarn
    @yarn = Yarn.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Yarn not found."
    redirect_to yarns_path
  rescue StandardError => e
    flash[:alert] = "An error occurred: #{e.message}"
    redirect_to yarns_path
  rescue Exception => e
    flash[:alert] = "An unexpected error occurred: #{e.message}"
    redirect_to yarns_path
  rescue => e
    flash[:alert] = "An error occurred: #{e.message}"
    redirect_to yarns_path
  end
end
