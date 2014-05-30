require 'spec_helper'

describe LineItem do
  subject! { create :line_item }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  it { should belong_to(:product) }
  it { should belong_to(:order) }
  it { should validate_presence_of(:product_id) }

  describe 'validates order_status_is_draft' do

    context "when order is DRAFT" do
      it "can be updated" do
        expect(subject.update ({quantity: 4})).to be_true
      end
    end

    context "when order is PLACED" do
      before :each do
        subject.order.update(status: 'PLACED')
      end

      it 'cannot be updated' do
        expect(subject.update ({quantity: 4})).to be_false
      end
    end
  end
end
