require 'spec_helper'

describe Order do
  it { should ensure_inclusion_of(:status).
       in_array(%w(DRAFT PLACED PAID CANCELLED)).
       with_message("%{value} is not a valid status. Must be DRAFT, PLACED, PAID, or CANCELLED")
  }

  it { should have_many(:line_items) }
  it { should have_many(:products).through(:line_items) }
end
