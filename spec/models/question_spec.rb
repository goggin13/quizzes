require 'rails_helper'

RSpec.describe Question, type: :model do
  it "raises an exception on a non-unique prompt" do
    question = FactoryBot.create(:question)
    expect do
      FactoryBot.create(:question, prompt: question.prompt)
    end.to raise_exception(ActiveRecord::RecordInvalid)
  end

  describe "correct_answers" do
    before do
      @question = FactoryBot.create(:question)
      @answer_A = FactoryBot.create(:answer, question: @question, correct: true)
      @answer_B = FactoryBot.create(:answer, question: @question, correct: false)
    end

    context "one answer" do
      it "returns true if the correct answer is provided" do
        expect(@question.correct_answers?([@answer_A])).to eq(true)
      end

      it "returns false if the incorrect answer is provided" do
        expect(@question.correct_answers?([@answer_B])).to eq(false)
      end
    end

    context "multiselect" do
      before do
        @answer_C = FactoryBot.create(:answer, question: @question, correct: true)
      end

      it "returns true if the all correct answer are provided" do
        expect(@question.correct_answers?([@answer_A, @answer_C])).to eq(true)
      end

      it "returns true if the all correct answer are provided in a different order" do
        expect(@question.correct_answers?([@answer_C, @answer_A])).to eq(true)
      end

      it "returns false if one of the correct answers is not provided" do
        expect(@question.correct_answers?([@answer_A])).to eq(false)
      end

      it "returns false if one correct and one incorrect answer is provided" do
        expect(@question.correct_answers?([@answer_A, @answer_B])).to eq(false)
      end

      it "returns false if all incorrect answers are provided" do
        expect(@question.correct_answers?([@answer_B])).to eq(false)
      end
    end
  end
end
