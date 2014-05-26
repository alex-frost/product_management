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

    context "overwrites any status to be DRAFT" do
      let(:params) { {"date"=> (Date.current + 1.day), "status"=>"PAID"} }

      its(:status) { should eq('DRAFT') }
    end
  end

  context 'with line items' do
    subject { FactoryGirl.create :order, :with_line_items }

    it "#net_price sums the products" do
      expect(subject.net_price).to eq(2.4)
    end

    it "#gross_price sums the products with VAT" do
      expect(subject.gross_price).to eq(2.4*1.2)
    end
  end
end
