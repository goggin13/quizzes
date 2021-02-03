FactoryBot.define do
  factory :user_answer do
    association :question
    association :user
    association :answer
  end
end
