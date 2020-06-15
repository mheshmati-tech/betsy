class Product < ApplicationRecord
  #TODO product belongs to a user
  belongs_to :user
<<<<<<< HEAD
  has_and_belongs_to_many  :categories

=======
  has_many :order_items
  has_and_belongs_to_many :categories
>>>>>>> 0766c9b716f919946dab82dee24ca009e14c16be

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  
end
