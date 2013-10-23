# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "MyString"
    password "MyString"
    display_name "MyString"
    first_name "MyString"
    last_name "MyString"
  end
end
