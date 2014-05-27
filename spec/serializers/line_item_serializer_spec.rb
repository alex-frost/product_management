describe LineItemSerializer do
  it "creates JSON with attributes" do
    line_item  = create :line_item
    serializer = LineItemSerializer.new line_item
    expect(serializer.to_json).to eql('{"line_item":{"id":' + line_item.to_param +
                                      ',"quantity":1,"product_id":'+ line_item.product.to_param + 
                                      '}}')
  end
end
