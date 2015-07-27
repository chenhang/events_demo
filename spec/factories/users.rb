FactoryGirl.define do
  factory :user do
    association :team
    sequence(:name) {|n| "test_user_{n}"}
  end
end