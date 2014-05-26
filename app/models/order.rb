class Order < ActiveRecord::Base
  validates :status, inclusion: { in: %w(DRAFT PLACED PAID CANCELLED),
                                  message: "%{value} is not a valid status. Must be DRAFT, PLACED, PAID, or CANCELLED" }

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

  def update(attributes = nil, options = {})
    check_status(attributes)
  end

  def change_status_valid?(new_status)
    if status == "DRAFT"
      case new_status
      when "CANCELLED"
        true
      when "PLACED"
        line_items.any?
      else
        false
      end
    end
  end
end
