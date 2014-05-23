class Order < ActiveRecord::Base
  validates :status, inclusion: { in: %w(DRAFT PLACED PAID CANCELLED),
                                  message: "%{value} is not a valid status. Must be DRAFT, PLACED, PAID, or CANCELLED" }
end
