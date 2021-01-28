require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    @exam = FactoryBot.create(:exam)
    assign(:questions, [
      FactoryBot.create(:question, exam: @exam),
      FactoryBot.create(:question, exam: @exam)
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", text: "Prompt".to_s, count: 2
    assert_select "tr>td", text: "Source".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
