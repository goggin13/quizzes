FactoryBot.define do
  factory :user_result do
    association :question
    association :user
    association :exam
    correct { false }
  end
end
