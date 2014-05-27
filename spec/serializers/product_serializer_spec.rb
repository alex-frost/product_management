describe ProductSerializer do
  it "creates JSON with attributes" do
    product  = create :product
    serializer = ProductSerializer.new product
    expect(serializer.to_json).to eql('{"product":{"id":' + product.to_param +
                                      ',"name":"' + product.name + '","net_price":1.2}}')
  end
end
