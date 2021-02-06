require 'rails_helper'

RSpec.describe AnswerService do
  before do
    @exam = FactoryBot.create(:exam)
    @user = FactoryBot.create(:user)
    @question = FactoryBot.create(:question, exam: @exam)
    @answer_A = FactoryBot.create(:answer, question: @question, correct: true)
    @answer_B = FactoryBot.create(:answer, question: @question, correct: false)
    @answer_C = FactoryBot.create(:answer, question: @question, correct: true)
    @service = AnswerService.new(@user)
  end

  describe "record_answers" do
    it "records a user result" do
      expect do
        @service.record_answers(@question, [@answer_A.id])
      end.to change(UserResult, :count).by(1)
    end

    it "links the result to the exam, user, and question" do
      user_result = @service.record_answers(@question, [@answer_A.id])
      expect(user_result.exam_id).to eq(@exam.id)
      expect(user_result.user_id).to eq(@user.id)
      expect(user_result.question_id).to eq(@question.id)
      expect(user_result.correct).to eq(false)
    end

    it "saves a correct multiselect answer" do
      user_result = @service.record_answers(@question, [@answer_A.id, @answer_C.id])
      expect(user_result.correct).to eq(true)
    end

    it "records a user answer for each provided answer" do
      expect do
        @service.record_answers(@question, [@answer_A.id, @answer_B.id])
      end.to change(UserAnswer, :count).by(2)
    end

    it "links user answers appropriately" do
      @service.record_answers(@question, [@answer_A.id, @answer_B.id])
      expect(UserAnswer.where(answer_id: @answer_A.id, user_id: @user.id).count).to eq(1)
      expect(UserAnswer.where(answer_id: @answer_B.id, user_id: @user.id).count).to eq(1)
    end
  end
end
