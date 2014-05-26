class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :date, :net_price, :gross_price
end
