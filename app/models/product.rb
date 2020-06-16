class Product < ApplicationRecord
  #TODO product belongs to a user
  belongs_to :user
  has_many :order_items
  has_many :reviews
  has_and_belongs_to_many :categories


  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def average_rating 
    length = self.reviews.length

    return 0 if length == 0 
      
    total_rating = self.reviews.sum { |review| review.rating }
    
    return (total_rating / length).round(1)
  end
  
end
