class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :quantity, numericality: {greater_than: 0}

  validate :order_status_is_draft

  def order_status_is_draft
    unless order.status == 'DRAFT'
      errors.add(:order_id, "Order status is not DRAFT")
    end
  end
end
