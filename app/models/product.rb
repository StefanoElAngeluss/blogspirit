class Product < ApplicationRecord
  validates :name, :description, :price, presence: true

  def to_s
    name
  end
  
end
