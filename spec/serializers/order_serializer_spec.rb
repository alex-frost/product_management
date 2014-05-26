describe OrderSerializer do
  it "creates JSON with attributes" do
    order  = FactoryGirl.create :order
    serializer = OrderSerializer.new order
    expect(serializer.to_json).to eql('{"order":{"id":' + order.to_param +
                                      ',"status":"DRAFT","date":"' + order.date.strftime("%Y-%m-%d") +
                                      '","net_price":0,"gross_price":0.0}}')
  end
end
