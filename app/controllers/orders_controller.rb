class OrdersController < ApplicationController
  def show
    # @order_items = OrderItems.where(:order_id)
    @order_items = Order.order_items
  end

  def create
    if @current_order.nil?
      @current_order = Order.new
    end
  end
end
