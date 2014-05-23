class Product < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :net_price, numericality: {greater_than_or_equal_to: 0}
end
