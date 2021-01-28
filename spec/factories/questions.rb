FactoryBot.define do
  factory :question do
    prompt { "Prompt" }
    source { "MyString" }
    explanation { "MyText" }
    association :exam
  end
end
