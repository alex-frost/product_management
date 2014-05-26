class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :product_id
end
