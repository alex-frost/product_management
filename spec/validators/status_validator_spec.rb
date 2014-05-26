describe StatusValidator do
  let(:params) { {"date"=> (Date.current + 1.day)} }
  subject {Order.create! params}

  context "with status DRAFT" do
    context "with no line items" do
      it "cannot be PLACED" do
        expect(subject.update(status: "PLACED")).to be_false
      end

      it "can be CANCELLED" do
        expect(subject.update(status: "CANCELLED")).to be_true
      end

      it "cannot be PAID" do
        expect(subject.update(status: "PAID")).to be_false
      end
    end

    context "with line items" do
      before :each do
        product = Product.create!(name: "Product Name", net_price: 1.20)
        subject.line_items.create!(quantity: 2, product_id: product.id)
      end

      it "can be PLACED" do
        expect(subject.update(status: "PLACED")).to be_true
      end

      it "can be CANCELLED" do
        expect(subject.update(status: "CANCELLED")).to be_true
      end

      it "cannot be PAID" do
        expect(subject.update(status: "PAID")).to be_false
      end
    end
  end

  context "with status PLACED" do
    before :each do
      product = Product.create!(name: "Product Name", net_price: 1.20)
      subject.line_items.create!(quantity: 2, product_id: product.id)
      subject.update(status: "PLACED")
    end

    it "cannot be DRAFT" do
      expect(subject.update(status: "DRAFT")).to be_false
    end

    it "can be CANCELLED" do
      expect(subject.update(status: "CANCELLED")).to be_true
    end

    it "can be PAID" do
      expect(subject.update(status: "PAID")).to be_true
    end
  end

  context "with status PAID" do
    before :each do
      product = Product.create!(name: "Product Name", net_price: 1.20)
      subject.line_items.create!(quantity: 2, product_id: product.id)
      subject.update(status: "PLACED")
      subject.update(status: "PAID")
    end

    it "cannot be changed" do
      expect(subject.update(status: "PLACED")).to be_false
    end
  end

  context "with status CANCELLED" do
    before :each do
      subject.update(status: "CANCELLED")
    end

    it "cannot be changed" do
      expect(subject.update(status: "DRAFT")).to be_false
    end
  end

end

