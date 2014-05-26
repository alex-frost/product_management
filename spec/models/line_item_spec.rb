require 'spec_helper'

describe LineItem do
  let(:order) { Order.create! ({ "date" => "2014-05-23"}) }
  subject {order.line_items.new}

  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  it { should belong_to(:product) }
  it { should belong_to(:order) }

  describe 'validates order_status_is_draft' do
    let(:product) { Product.create! ({ "name" => "New Product", "net_price" => 1.23 }) }

    subject! {order.line_items.create! ({"product_id" => product.to_param, "quantity" => 3}) }

    context "when order is DRAFT" do
      it "can be updated" do
        expect(subject.update ({quantity: 4})).to be_true
      end
    end

    context "when order is PLACED" do
      before :each do
        order.update(status: 'PLACED')
      end

      it 'cannot be updated' do
        expect(subject.update ({quantity: 4})).to be_false
      end
    end
  end
end
