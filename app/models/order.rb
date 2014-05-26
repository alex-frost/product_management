class Order < ActiveRecord::Base
  validates :status, inclusion: { in: %w(DRAFT PLACED PAID CANCELLED),
                                  message: "%{value} is not a valid status. Must be DRAFT, PLACED, PAID, or CANCELLED" }
  validates :status, status: true

  has_many :line_items, inverse_of: :order
  has_many :products, through: :line_items

  def self.new(attributes = nil, options = {})

    attributes ||= {}
    if !(attributes.keys.include? "vat")
      attributes.merge!("vat" => Vat.instance.amount )
    end

    attributes.merge!("status" => "DRAFT" )

    super
  end

end
