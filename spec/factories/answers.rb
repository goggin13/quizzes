FactoryBot.define do
  factory :answer do
    sequence(:prompt) { |n| "Answer-Prompt-#{n}" }
    correct { false }
    association :question
  end
end
