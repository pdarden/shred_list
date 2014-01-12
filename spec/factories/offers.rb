# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :offer do
    user_id 1
    listing_id 1
    description "I'll trade you a cat for that."
    private_message false

    trait :private_message do
      private_message true
    end
  end
end
