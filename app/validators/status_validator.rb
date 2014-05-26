class StatusValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, new_status)

    if record.persisted?
      order = Order.find record.id
    else
      return
    end

    if order.status == new_status
      return
    end

    case order.status
    when "DRAFT"
      case new_status
      when "CANCELLED"
      when "PLACED"
        if order.line_items.empty?
          record.errors[attribute] << "cannot be PLACED with no line items"
        end
      else
        record.errors[attribute] << "status change from DRAFT to #{new_status} is invalid"
      end
    when "PLACED"
      case new_status
      when "CANCELLED"
      when "PAID"
      else
        record.errors[attribute] << "status change from PLACED to #{new_status} is invalid"
      end
    when "PAID"
      record.errors[attribute] << "status change from PAID to #{new_status} is invalid"
    when "CANCELLED"
      record.errors[attribute] << "status change from CANCELLED to #{new_status} is invalid"
    end
  end
end
