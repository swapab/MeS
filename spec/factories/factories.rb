# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
    name        { Faker::Name.name }
    age         { rand(10..30) }
    email_id    { Faker::Internet.email }
    location    { Faker::Address.street_address }
    department  { Faker::Commerce.department }
    designation { Faker::Lorem.word }
  end
end
