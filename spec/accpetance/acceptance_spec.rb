require 'spec_helper'

describe 'product management API', type: :controller do
  it do
    get "/products"
    #post "/products", {product: attributes_for(:product)}
  end

end
