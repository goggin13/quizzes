FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "tester_#{n}@example.com" }
    password { "pass123" }
    password_confirmation { "pass123" }

    trait :admin do
      email { User::ADMIN_EMAIL }
    end
  end
end
