class OrderItem < ApplicationRecord

  belongs_to :product
  belongs_to :order

  def calculate_total
    product = Product.find_by(id: self.product_id)
    return self.quantity * product.price
  end

end
