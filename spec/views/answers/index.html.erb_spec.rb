require 'rails_helper'

RSpec.describe "answers/index", type: :view do
  before(:each) do
    @question = FactoryBot.create(:question)
    assign(:answers, [
      FactoryBot.create(:answer, question: @question),
      FactoryBot.create(:answer, question: @question)
    ])
  end

  it "renders a list of answers" do
    render
    assert_select "tr>td", text: "MyString".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
