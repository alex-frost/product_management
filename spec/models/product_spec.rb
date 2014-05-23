require 'spec_helper'

describe Product do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_numericality_of(:net_price).is_greater_than_or_equal_to(0) }
end
