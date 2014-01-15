# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    equipment_id 1
    image "spec/file_fixtures/sample_longboard.jpg"
  end
end
