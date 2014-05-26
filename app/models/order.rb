class Order < ActiveRecord::Base
  validates :status, inclusion: { in: %w(DRAFT PLACED PAID CANCELLED),
                                  message: "%{value} is not a valid status. Must be DRAFT, PLACED, PAID, or CANCELLED" }

  has_many :line_items, inverse_of: :order
  has_many :products, through: :line_items
end
