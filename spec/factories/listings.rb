# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing do
    user_id 1
    title "Selling a new board I won"
    description "This is brand new. I won it at Broadway Bomb."
    trade false
    state_id 1
    asking_price 20000
    asking_items "none"
  end
end
