FactoryBot.define do
  factory :question do
    sequence(:prompt) { |n| "Prompt-#{n}" }
    source { "MyString" }
    explanation { "MyText" }
    association :exam
  end
end
