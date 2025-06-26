class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :email, :password ])
  end

  # Add any additional methods or filters here
end
