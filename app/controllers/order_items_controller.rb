class OrderItemsController < ApplicationController
  before_action :find_order_item, only: [:update, :destroy, :change_order_item_status]

  def create
    order_item = OrderItem.new(quantity: params[:quantity], product_id: params[:product_id])
    if !order_item.is_in_stock
      flash[:error] = "Not enough inventory available."
      redirect_to product_path(params[:product_id])
      return
    else
      if @current_order
        existing_order(order_item)
      else
        @current_order = Order.create(order_status: "pending")
        session[:order_id] = @current_order.id
        order_item.order_id = @current_order.id
      end
    end

    save_order(order_item)
  end

  def existing_order(order_item)
    order_item.order_id = session[:order_id]
    existing_order_item = @current_order.order_items.find_by(product_id: params[:product_id])
    if existing_order_item
      new_quantity = existing_order_item.quantity += params[:quantity].to_i #checking the new quantity before saving the changes
      if existing_order_item.stock < new_quantity
        flash[:error] = "Not enough inventory available."
        redirect_to product_path(params[:product_id])
        return
      end
      save_order(existing_order_item)
    end
  end

  def save_order(order_item)
    if order_item.save
      flash[:success] = "Success!"
      redirect_to product_path(params[:product_id])
      return
    else
      flash[:error] = "Error! #{order_item.errors.messages}"
      redirect_to product_path(params[:product_id])
      return
    end
  end

  def update
    if @order_item.update(order_item_params)
      flash[:success] = "Successfully updated order item."
      redirect_to order_path(@current_order.id)
      return
    else
      flash[:error] = "Unable to update your order. #{@order_item.errors.messages}."
      return
    end
  end

  def destroy
    @order_item.destroy
    redirect_to order_path(@current_order.id)
  end

  def change_order_item_status
    @order_item.order_item_status = "shipped"
    @order_item.save
    @order_item.order.set_status_of_order_to_complete_if_order_items_are_shipped
    redirect_to myorders_path
    return
  end

  private

  def order_item_params
    return params.require(:order_item).permit(:quantity)
  end

  def find_order_item
    @order_item = OrderItem.find_by(id: params[:id])
    if @order_item.nil?
      flash[:error] = "could not find order item."
      redirect_to root_path
      return
    end
  end
end
