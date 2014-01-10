# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing do
    user_id 1
    title "Selling a new board I won"
    description "This is brand new. I won it at Broadway Bomb."
    trade false
    state_id 1
    asking_price 20000
    asking_items ""

    trait :invalid_asking_price do
      asking_price '$200.35'
    end

    trait :trade do
      trade true
      asking_price ''
      asking_items 'What ever you have to offer'
    end

  end
end
