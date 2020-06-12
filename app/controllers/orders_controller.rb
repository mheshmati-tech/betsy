class OrdersController < ApplicationController
  def show
    @order_items = OrderItem.where(order_id: @current_order.id)
    
    # @order_items = Order.order_items
  end

  def create
    if @current_order.nil?
      @current_order = Order.new
    end
  end
end
