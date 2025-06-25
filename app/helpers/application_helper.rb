module ApplicationHelper

  def set_order_from_params(params:, default_attribute:, direction:"ASC")
    @order_by = params[:order_by] || default_attribute
    @order_direction = params[:order_direction] || direction
    @order_string = "#{@order_by} #{@order_direction}"
  end

end
