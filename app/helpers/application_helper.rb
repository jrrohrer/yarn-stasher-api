module ApplicationHelper
  def param_redirect_or_default(param, default)
    if params[param].present?
      params[param]
    else
      default
    end
  end
end
