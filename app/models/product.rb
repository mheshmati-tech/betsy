class Product < ApplicationRecord
  #TODO product belongs to a user
  belongs_to :user
  has_many :order_items

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  
end
