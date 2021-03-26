require 'rails_helper'

RSpec.describe "questions/new", type: :view do
  before(:each) do
    @exam = FactoryBot.create(:exam)
    assign(:question, Question.new(
      prompt: "MyString",
      source: "MyString",
      explanation: "MyText",
      exam: @exam
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", exam_questions_path(@exam), "post" do

      assert_select "textarea[name=?]", "question[prompt]"

      assert_select "textarea[name=?]", "question[source]"

      assert_select "textarea[name=?]", "question[explanation]"
    end
  end
end
