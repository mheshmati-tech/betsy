class Product < ApplicationRecord
  #TODO product belongs to a user
  # belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
