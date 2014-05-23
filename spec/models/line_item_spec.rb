require 'spec_helper'

describe LineItem do
  it { should validate_numericality_of(:quantity).is_greater_than(0) }
end
