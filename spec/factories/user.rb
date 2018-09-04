FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "andrew#{i}@example.com" }
    password "password"
    admin false
  end
end
