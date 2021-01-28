require 'rails_helper'

RSpec.describe "exams/edit", type: :view do
  before(:each) do
    @exam = assign(:exam, Exam.create!(
      title: "MyString",
      open: false
    ))
  end

  it "renders the edit exam form" do
    render

    assert_select "form[action=?][method=?]", exam_path(@exam), "post" do

      assert_select "input[name=?]", "exam[title]"

      assert_select "input[name=?]", "exam[open]"
    end
  end
end
