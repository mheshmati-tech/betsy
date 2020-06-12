class Product < ApplicationRecord
  #TODO product belongs to a user
  belongs_to :user
  has_and_belongs_to_many  :categories


  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  
end
