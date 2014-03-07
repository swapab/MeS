# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
    name "Grey Joy"
    age 1
    email_id "grey@joy.com"
    location "Ire"
    department "Defence"
    designation "Sargent"
  end
end
