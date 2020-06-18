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
    if self.quantity <= self.stock
      return true
    else
      return false
    end
  end
  
end
