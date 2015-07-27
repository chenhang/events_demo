FactoryGirl.define do
  factory :team do
    sequence(:name) {|n| "test_team_{n}"}
  end
end