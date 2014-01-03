# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :offer do
    user_id 1
    listing_id 1
    description "MyText"
    private_message false
  end
end
