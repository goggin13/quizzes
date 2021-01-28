require 'rails_helper'

RSpec.describe "answers/new", type: :view do
  before(:each) do
    @question = FactoryBot.create(:question)
    assign(:answer, Answer.new(
      prompt: "MyString",
      correct: false,
      question: @question
    ))
  end

  it "renders new answer form" do
    render

    assert_select "form[action=?][method=?]", question_answers_path(@question), "post" do

      assert_select "input[name=?]", "answer[prompt]"

      assert_select "input[name=?]", "answer[correct]"

      assert_select "input[name=?]", "answer[question_id]"
    end
  end
end
