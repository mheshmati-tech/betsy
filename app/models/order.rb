class Order < ApplicationRecord
  validate :order_has_to_have_at_least_one_order_item_to_be_placed, on: :update

  validates :email_address, presence: true, on: :update
  validates :mailing_address, presence: true, on: :update
  validates :name_on_credit_card, presence: true, on: :update
  validates :credit_card_number, presence: true, numericality: true, on: :update
  validates :credit_card_expiration, presence: true, on: :update
  validates :credit_card_CVV, presence: true, numericality: true, on: :update
  validates :billing_zip_code, presence: true, on: :update

  def order_has_to_have_at_least_one_order_item_to_be_placed
    if order_items.count == 0
      errors.add(:order_items, "can't place an order without any order items")
    end
  end

  has_many :order_items

  def calculate_order_total
    order_items = OrderItem.where(order_id: self.id)
    return order_items.map { |order_item| order_item.calculate_total }.sum
  end

end
