class Order < ActiveRecord::Base
  validates :status, inclusion: { in: %w(DRAFT PLACED PAID CANCELLED),
                                  message: "%{value} is not a valid status. Must be DRAFT, PLACED, PAID, or CANCELLED" }
  validates :date, on: :create, date: { after: Proc.new { Time.now } }
  validates :status, status: true

  has_many :line_items, inverse_of: :order
  has_many :products, through: :line_items

  before_validation :add_default_vat, :overwrite_status_with_draft, on: :create


  def net_price
    line_items.inject(0) do |sum, line_item|
      sum += line_item.quantity * line_item.product.net_price
    end
  end

  def gross_price
    net_price*(1.0 + vat)
  end

  private

  def overwrite_status_with_draft
    update_attribute(:status, 'DRAFT')
  end

  def add_default_vat
    update_attribute(:vat, 0.2) unless vat
  end

end
