# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reply do
    offer_id 1
    sender_id 1
    body "MyText"
  end
end
