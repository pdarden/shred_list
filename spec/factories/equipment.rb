# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :equipment do
    brand_id 10
    category_id 2
    riding_style_id 1
    original_price 15000
  end
end
