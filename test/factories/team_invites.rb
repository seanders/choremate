# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_invite do
    team nil
    token "MyString"
    email "MyString"
  end
end
