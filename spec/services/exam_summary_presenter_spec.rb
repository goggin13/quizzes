require 'rails_helper'

RSpec.describe ExamSummaryPresenter do
  before do
    @user = FactoryBot.create(:user)
    @exam = FactoryBot.create(:exam, open: true)
    @question = FactoryBot.create(:question, exam: @exam)
    @answer_A = FactoryBot.create(:answer, question: @question, correct: true)
    @answer_B = FactoryBot.create(:answer, question: @question, correct: false)
    @answer_C = FactoryBot.create(:answer, question: @question, correct: false)
    AnswerService.new(@user).record_answers(@question, [@answer_A.id])
    AnswerService.new(FactoryBot.create(:user)).record_answers(@question, [@answer_B.id])
  end

  describe "questions" do
    it "returns an ExamSummaryPresenter::Row for each question" do
      rows = ExamSummaryPresenter.new(@exam, @user).rows
      expect(rows.length).to eq(1)
      expect(rows[0].class).to eq(ExamSummaryPresenter::Row)
    end

    it "provides a row with the question prompt" do
      rows = ExamSummaryPresenter.new(@exam, @user).rows
      expect(rows[0].question_prompt).to eq(@question.prompt)
    end

    it "provides a row with an array of answers" do
      rows = ExamSummaryPresenter.new(@exam, @user).rows
      row = rows[0]
      expect(row.answers.length).to eq(3)
      expect(row.answers.map(&:prompt).sort).to eq([
        @answer_A.prompt,
        @answer_B.prompt,
        @answer_C.prompt,
      ].sort)
    end

    it "tells which answer the user selected" do
      rows = ExamSummaryPresenter.new(@exam, @user).rows
      row = rows[0]
      expect(row.answers.length).to eq(3)
      expect(row.answers.map(&:user_selected)).to eq([
        true, false, false
      ])
    end

    it "tells which answer is correct" do
      rows = ExamSummaryPresenter.new(@exam, @user).rows
      row = rows[0]
      expect(row.answers.length).to eq(3)
      expect(row.answers.map(&:correct)).to eq([
        true, false, false
      ])
    end

    it "tells how many people answered the question" do
      expect(UserResult.count).to eq(2)
      rows = ExamSummaryPresenter.new(@exam, @user).rows
      row = rows[0]
      expect(row.answered_by_count).to eq(2)
    end

    it "tells how many people selected each option" do
      rows = ExamSummaryPresenter.new(@exam, @user).rows
      row = rows[0]
      expect(row.answers.map(&:selected_by_count)).to eq([
        1, 1, 0
      ])
    end

    it "tells the percentage of people who selected each answer" do
      rows = ExamSummaryPresenter.new(@exam, @user).rows
      row = rows[0]
      expect(row.answers.map(&:selected_by_percentage)).to eq([
        0.5, 0.5, 0
      ])
    end

    it "handles multiple questions" do
      question_2 = FactoryBot.create(:question, exam: @exam)
      answer_2_A = FactoryBot.create(:answer, question: question_2, correct: true)
      answer_2_B = FactoryBot.create(:answer, question: question_2, correct: false)
      answer_2_C = FactoryBot.create(:answer, question: question_2, correct: false)
      AnswerService.new(@user).record_answers(question_2, [answer_2_A.id])
      AnswerService.new(FactoryBot.create(:user)).record_answers(question_2, [answer_2_B.id])

      rows = ExamSummaryPresenter.new(@exam, @user).rows
      row = rows[0]
      expect(rows.length).to eq(2)
    end
  end
end
