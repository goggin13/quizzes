FactoryBot.define do
  factory :answer do
    prompt { "MyString" }
    correct { false }
    association :question
  end
end
