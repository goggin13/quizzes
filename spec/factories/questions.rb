FactoryBot.define do
  factory :question do
    prompt { "Prompt" }
    source { "Source" }
    explanation { "MyText" }
    association :exam
  end
end
