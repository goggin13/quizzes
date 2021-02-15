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

  describe "completed_by_user_count" do
    before do
      @user = FactoryBot.create(:user)
      @exam = FactoryBot.create(:exam)
      @question_1 = FactoryBot.create(:question, exam: @exam)
      @question_2 = FactoryBot.create(:question, exam: @exam)
    end

    it "equals 0 if no user has completed the exam" do
      expect(@exam.completed_by_user_count).to eq(0)
    end

    it "equals 0 if a user has answered 1 of 2 questions" do
      user_result = FactoryBot.create(:user_result, question: @question_1, exam: @exam, user: @user)
      expect(@exam.completed_by_user_count).to eq(0)
    end

    it "returns 2 if 2 users have answered all the questions" do
      [@user, FactoryBot.create(:user)].each do |u|
        FactoryBot.create(:user_result, question: @question_1, exam: @exam, user: u)
        FactoryBot.create(:user_result, question: @question_2, exam: @exam, user: u)
      end

      expect(@exam.completed_by_user_count).to eq(2)
    end
  end
end
