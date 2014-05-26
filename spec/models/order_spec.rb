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
      let(:params) { {"date"=>"2014-05-23", "status"=>"DRAFT"} }

      its(:vat) { should eq(0.2) }
    end

    context "with vat in params" do
      let(:params) { {"date"=>"2014-05-23", "status"=>"DRAFT", "vat" => "0.15"} }

      its(:vat) { should eq(0.15) }
    end

    context "with no params" do
      let(:params) { }

      its(:vat) { should eq(nil) }
    end
  end
end
