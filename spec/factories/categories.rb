# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category_#{n}" }
    active true
  end
end
