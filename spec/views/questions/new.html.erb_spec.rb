require 'rails_helper'

RSpec.describe "questions/new", type: :view do
  before(:each) do
    assign(:question, Question.new(
      prompt: "MyString",
      source: "MyString",
      explanation: "MyText",
      exam: nil
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", questions_path, "post" do

      assert_select "input[name=?]", "question[prompt]"

      assert_select "input[name=?]", "question[source]"

      assert_select "textarea[name=?]", "question[explanation]"

      assert_select "input[name=?]", "question[exam_id]"
    end
  end
end
