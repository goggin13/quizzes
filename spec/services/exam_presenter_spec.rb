require 'rails_helper'

RSpec.describe ExamPresenter do
  before do
    @exam = FactoryBot.create(:exam, open: true, title: "302 Exam 1")
    @user = FactoryBot.create(:user)
    @question = FactoryBot.create(:question, exam: @exam)
    @answer_A = FactoryBot.create(:answer, question: @question, correct: true)
    @answer_B = FactoryBot.create(:answer, question: @question, correct: false)
    @question_2 = FactoryBot.create(:question, exam: @exam)
    @answer_A_2 = FactoryBot.create(:answer, question: @question_2, correct: true)
    @answer_B_2 = FactoryBot.create(:answer, question: @question_2, correct: false)
    @exam_url = "public/practice/#{@question.id}"
    @presenter = ExamPresenter.new(@exam, @user)
  end

  describe "prompt" do
    it "has the title of the exam" do
      expect(@presenter.prompt).to include("302 Exam 1")
    end

    context "a new exam" do
      it "has a link to 'Begin'" do
        expect(@presenter.prompt).to include("Begin")
        expect(@presenter.prompt).to include(@exam_url)
      end

      it "has the number of questions" do
        expect(@presenter.prompt).to include("( 2 questions )")
      end
    end

    context "a started exam" do
      before do
        AnswerService.new(@user).record_answers(@question, [@answer_A.id])
      end

      it "has a link to 'Continue'" do
        expect(@presenter.prompt).to include("Continue")
      end

      it "has a link to the next unanswered question" do
        next_question_url = "public/practice/#{@question_2.id}"
        expect(@presenter.prompt).to include(next_question_url)
      end

      it "reads how many questions have been answered" do
        expect(@presenter.prompt).to include("( 1/2 questions answered )")
      end
    end

    context "a completed exam" do
      before do
        AnswerService.new(@user).record_answers(@question, [@answer_A.id])
        AnswerService.new(@user).record_answers(@question_2, [@answer_B_2.id])
      end

      it "has a link to 'Review'" do
        expect(@presenter.prompt).to include("Review")
        expect(@presenter.prompt).to include("/public/summary/#{@exam.id}")
      end

      it "has the number of questions" do
        expect(@presenter.prompt).to include("( 2 questions )")
      end

      it "ends with the grade" do
        expect(@presenter.prompt).to include(" - 50%")
      end
    end
  end
end
