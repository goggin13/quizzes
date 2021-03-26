require 'rails_helper'

RSpec.describe "public/practice", type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
    @current_user = @user
    @exam = FactoryBot.create(:exam)
    @question = FactoryBot.create(:question, exam: @exam)
    @next_question = FactoryBot.create(:question, exam: @exam)
    @answer_A = FactoryBot.create(:answer, question: @question, correct: true)
    @answer_B = FactoryBot.create(:answer, question: @question, correct: false)
    @total = 2
    @index = 1
    @answered = false
  end

  it "adds an data-answer-id to each answer" do
    render
    expect(rendered).to match(/data-answer-id='#{@answer_A.id}'/)
    expect(rendered).to match(/data-answer-id='#{@answer_B.id}'/)
  end

  it "adds an data-question-id for the question" do
    render
    expect(rendered).to match(/data-question-id='#{@question.id}'/)
  end

  it "does not render the multi select button" do
    render
    expect(rendered).to_not match(/id="multi-select-submit"/)
  end

  it "renders the multi select button for a multi select question" do
    @answer_B.update_attribute(:correct, true)
    render
    expect(rendered).to match(/id="multi-select-submit"/)
  end

  it "adds the 'unanswered' class and removes 'answered' if the question has not been answered" do
    render
    expect(rendered).to match(/class="unanswered"/)
    expect(rendered).to_not match(/class="answered"/)
  end

  context "answered" do
    before do
      FactoryBot.create(:user_answer, user: @user, question: @question, answer: @answer_A)
      @answered = true
    end

    it "removes the 'unanswered' and adds 'answered' class if the question has been answered" do
      render
      expect(rendered).to_not match(/class="unanswered"/)
      expect(rendered).to match(/class="answered"/)
    end
  end
end
