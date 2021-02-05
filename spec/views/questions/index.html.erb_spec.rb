require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    @exam = FactoryBot.create(:exam)
    @questions = [
      FactoryBot.create(:question, exam: @exam, prompt: "Prompt-a"),
      FactoryBot.create(:question, exam: @exam, prompt: "Prompt-b"),
    ]
    assign(:questions, @questions)
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", text: "Prompt-a".to_s, count: 1
    assert_select "tr>td", text: "Prompt-b".to_s, count: 1
    assert_select "tr>td", text: "MyString".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    expect(rendered).to match("href=\"/questions/#{@questions[0].id}/answers\"")
    expect(rendered).to match("href=\"/questions/#{@questions[1].id}/answers\"")
  end
end
