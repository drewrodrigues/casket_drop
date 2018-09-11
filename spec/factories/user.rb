FactoryBot.define do
  factory :user do
    address "123 Example Street"
    bottom_fit "Skinny"
    city "New York"
    sequence(:email) { |i| "andrew#{i}@example.com" }
    password "password"
    shoe_size 8
    state "NY"
    style "Athletic"
    top_size "SM"
    waist_size 30
  end
end
