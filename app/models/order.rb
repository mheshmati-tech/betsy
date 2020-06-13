class Order < ApplicationRecord
  has_many :order_items

  def calculate_order_total
    order_items = OrderItem.where(order_id: self.id) # array of order items
    return order_items.map { |order_item| order_item.calculate_total }.sum
  end
  #TODO - ensure that if a product exists within the cart then increase the number of product otherwise add the order item to the cart 
  #this may need to be done in the order_item model?
  #method for calculating the quantity of a product in the cart 
  #if the product exists, then add that quantity to the quantity of product 



end
