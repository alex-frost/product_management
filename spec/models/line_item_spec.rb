require 'spec_helper'

describe LineItem do
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
end
