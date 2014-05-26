class Order < ActiveRecord::Base
  validates :status, inclusion: { in: %w(DRAFT PLACED PAID CANCELLED),
                                  message: "%{value} is not a valid status. Must be DRAFT, PLACED, PAID, or CANCELLED" }

  has_many :line_items, inverse_of: :order
  has_many :products, through: :line_items

  def self.new(attributes = nil, options = {})
    if attributes && !(attributes.keys.include? "vat")
      attributes.merge!("vat" => Vat.instance.amount )
    end

    super
  end
end
