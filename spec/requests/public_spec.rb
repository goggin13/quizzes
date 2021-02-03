 require 'rails_helper'

RSpec.describe "/public", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @question = FactoryBot.create(:question)
    @answer_A = FactoryBot.create(:answer, question: @question, correct: true)
    @answer_B = FactoryBot.create(:answer, question: @question, correct: true)
    sign_in @user
  end

  describe "answer" do
    it "saves an answer to a question" do
      expect do
        post "/public/answer/#{@question.id}", params: {
          answer_ids: [@answer_A.id]
        }
      end.to change(UserAnswer, :count).by(1)
    end

    it "records multiple user answers" do
      expect do
        post "/public/answer/#{@question.id}", params: {
          answer_ids: [@answer_A.id, @answer_B.id]
        }
      end.to change(UserAnswer, :count).by(2)

      expect(UserAnswer.where(user: @user, question: @question, answer: @answer_A).count).to eq(1)
      expect(UserAnswer.where(user: @user, question: @question, answer: @answer_B).count).to eq(1)
    end

    it "saves a user answer that links the correct objects" do
      post "/public/answer/#{@question.id}", params: {
        answer_ids: [@answer_A.id]
      }
      user_answer = UserAnswer.last!
      expect(user_answer.user_id).to eq(@user.id)
      expect(user_answer.question_id).to eq(@question.id)
      expect(user_answer.answer_id).to eq(@answer_A.id)
    end

    it "returns success" do
      post "/public/answer/#{@question.id}", params: {
        answer_ids: [@answer_A.id]
      }
      expect(response).to be_successful
    end
  end
end
