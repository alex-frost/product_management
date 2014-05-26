describe VatSerializer do
  it "creates JSON with attributes" do
    serializer = VatSerializer.new Vat.instance
    expect(serializer.to_json).to eql('{"vat":{"amount":0.2}}')
  end
end
