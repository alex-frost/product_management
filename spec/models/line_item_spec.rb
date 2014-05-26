require 'spec_helper'

describe LineItem do
  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  it { should belong_to(:product) }
  it { should belong_to(:order) }
end
