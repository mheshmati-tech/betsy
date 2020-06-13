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

  def edit
    if @current_order.nil?
      flash[:error] = "Order does not exist"
      return redirect_to root_path
    elsif params[:id].to_i != @current_order.id
      flash[:error] = "You can't edit an order that isn't yours"
      return redirect_to root_path
    end
  end

  def update
    if @current_order.update(order_params)
      flash[:success] = "Order ##{@order.id} successfully placed"
      redirect_to root_path
      # TODO - we want to redirect to reciept page (order with status paid/completed)
      return
    end
  end

  private

  def order_params
    return params.require(:order).permit(:email_address, :mailing_address, :name_on_credit_card, :credit_card_number, :credit_card_expiration, :credit_card_CVV, :billing_zip_code)
  end
end
