class UsersController < ApplicationController
  include ApplicationHelper

  before_action :set_user, except: %i[index new create]

  def index
    @users = User.all
    sort_order = set_order_from_params(params: params, default_attribute: 'username')
    @users = @users.order(sort_order)

    render json: @users
  end

  def new
    @user = User.new
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def edit
    render json: @user, status: :ok
  end

  def update
    if @user.update(user_params)
      redirect_to @user
      render json: @user, status: :updated
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    @yarns = @user.yarns.order(:colorway)
    @projects = @user.projects.order(:title)
    @projects = @projects.includes(:yarns) if @projects.any?  # Eager load yarns for projects to avoid N+1 queries

    render json: {
      user: @user,
      yarns: @yarns,
      projects: @projects
    }, status: :ok
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password,)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
