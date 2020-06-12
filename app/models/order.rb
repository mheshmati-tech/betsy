class Order < ApplicationRecord
  has_many :order_items

  def calculate_order_total
    order_items = OrderItem.where(order_id: self.id) # array of order items
    return order_items.map { |order_item| order_item.calculate_total }.sum
  end

end
