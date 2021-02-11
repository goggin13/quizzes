require 'rails_helper'

RSpec.describe Exam, type: :model do
  it "can be destroyed along with the associated answers" do
    exam = FactoryBot.create(:exam)
    question = FactoryBot.create(:question, exam: exam)
    answer = FactoryBot.create(:answer, question: question)
    user_answer = FactoryBot.create(:user_answer, answer: answer, question: question)
    user_result = FactoryBot.create(:user_result, question: question, exam: exam)

    exam.destroy
    expect(Question.count).to eq(0)
    expect(Answer.count).to eq(0)
    expect(UserAnswer.count).to eq(0)
  end
end
