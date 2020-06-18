class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def calculate_total
    # product = Product.find_by(id: self.product_id)
    return self.quantity * product.price
  end

  def stock
    product.stock
  end

  def is_in_stock
    return self.quantity <= self.stock
  end
end
