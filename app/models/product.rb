class Product < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_and_belongs_to_many :categories

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  
end
