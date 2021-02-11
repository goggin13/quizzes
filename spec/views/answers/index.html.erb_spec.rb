require 'rails_helper'

RSpec.describe "answers/index", type: :view do
  before(:each) do
    @question = FactoryBot.create(:question)
    assign(:answers, [
      FactoryBot.create(:answer, prompt: "hello", question: @question, correct: true),
      FactoryBot.create(:answer, prompt: "world", question: @question, correct: false),
    ])
  end

  it "renders a list of answers" do
    render
    assert_select "tr>td", text: "hello", count: 1
    assert_select "tr>td", text: "world", count: 1
    assert_select "tr>td", text: false.to_s, count: 1
    assert_select "tr>td", text: true.to_s, count: 1
  end
end
