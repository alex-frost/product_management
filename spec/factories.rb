FactoryGirl.define do
  sequence(:product_name) { |n| "My product nos. #{n}" }

  factory :product do
    name { generate(:product_name) }
    net_price "1.2"
  end

  factory :order do
    date Date.current + 2.days
  end

  factory :line_item do
    quantity "1"
    product
    order
  end

  trait :with_line_items do
    after :create do |order|
      FactoryGirl.create_list :line_item, 2, order: order
    end
  end

end
