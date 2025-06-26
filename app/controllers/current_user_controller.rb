class CurrentUserController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: User.new(current_user.attributes), status: :ok
  end
end
