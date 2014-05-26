require 'spec_helper'

describe Order do
  it { should ensure_inclusion_of(:status).
       in_array(%w(DRAFT PLACED PAID CANCELLED)).
       with_message("%{value} is not a valid status. Must be DRAFT, PLACED, PAID, or CANCELLED")
  }

  it { should have_many(:line_items) }
  it { should have_many(:products).through(:line_items) }

  describe "#self.new" do
    subject {Order.new params}

    context "with no vat in params" do
      let(:params) { {"date"=> (Date.current + 1.day), "status"=>"DRAFT"} }

      its(:vat) { should eq(0.2) }
    end

    context "with vat in params" do
      let(:params) { {"date"=> (Date.current + 1.day), "status"=>"DRAFT", "vat" => "0.15"} }

      its(:vat) { should eq(0.15) }
    end

    context "with no params" do
      let(:params) { }

      its(:vat) { should eq(0.2) }
    end
  end

  describe "#change_status_valid?" do
    let(:params) { {"date"=> (Date.current + 1.day)} }
    subject {Order.create! params}

    context "with status DRAFT" do
      context "with no line items" do
        it "cannot be PLACED" do
          expect(subject.change_status_valid?("PLACED")).to eq(false)
        end

        it "can be CANCELLED" do
          expect(subject.change_status_valid?("CANCELLED")).to eq(true)
        end

        it "cannot be PAID" do
          expect(subject.change_status_valid?("PAID")).to eq(false)
        end
      end

      context "with line items" do
        before :each do
          product = Product.create!(name: "Product Name", net_price: 1.20)
          subject.line_items.create!(quantity: 2, product_id: product.id)
        end

        it "can be PLACED" do
          expect(subject.change_status_valid?("PLACED")).to eq(true)
        end

        it "can be CANCELLED" do
          expect(subject.change_status_valid?("CANCELLED")).to eq(true)
        end

        it "cannot be PAID" do
          expect(subject.change_status_valid?("PAID")).to eq(false)
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
        expect(subject.change_status_valid?("DRAFT")).to eq(false)
      end

      it "can be CANCELLED" do
        expect(subject.change_status_valid?("CANCELLED")).to eq(true)
      end

      it "can be PAID" do
        expect(subject.change_status_valid?("PAID")).to eq(true)
      end
    end

    context "with status PAID" do
      before :each do
        product = Product.create!(name: "Product Name", net_price: 1.20)
        subject.line_items.create!(quantity: 2, product_id: product.id)
        subject.update(status: "PAID")
      end

      it "cannot be changed" do
        expect(subject.change_status_valid?("PLACED")).to eq(false)
      end
    end

    context "with status CANCELLED" do
      before :each do
        subject.update(status: "CANCELLED")
      end

      it "cannot be changed" do
        expect(subject.change_status_valid?("DRAFT")).to eq(false)
      end
    end

  end
end
