class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :product_id, :product_name

  def product_name
    object.product.name
  end
end
