class OrderItemsController < ApplicationController
  before_action :find_order_item, only: [:update, :destroy]

  def create
    # product = Product.find_by(id: params[:product_id])
    order_item = OrderItem.new(quantity: params[:quantity], product_id: params[:product_id])

    if @current_order
      order_item.order_id = session[:order_id]
    else
      @current_order = Order.create(order_status: "pending")
      session[:order_id] = @current_order.id
      order_item.order_id = @current_order.id
    end

    if order_item.save
      flash[:success] = "order item succesfully created"
      redirect_to root_path
      return
    else
      flash[:error] = "order item NOT succesfully created :( #{order_item.errors.messages}"
      redirect_to root_path
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

# {"authenticity_token"=>"j0N6hKMri5Q2Y+AJBLojxdOMlWdbDgil1pNzFXCtImRqrXyyQ6FYkGNapGLJAZkgPrI4+Y93jFkQUtk5Gc4oyw==",

#   "quantity"=>"2",
#   "commit"=>"Add to Cart",

#   "controller"=>"order_items",
#   "action"=>"create",
#   "product_id"=>"1"}