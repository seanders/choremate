# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :suggestion do
    title "MyString"
    description "MyString"
    point_value 1
    approved false
  end
end
