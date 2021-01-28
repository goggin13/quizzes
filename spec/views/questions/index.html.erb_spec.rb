require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      FactoryBot.create(:question),
      FactoryBot.create(:question)
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", text: "Prompt".to_s, count: 2
    assert_select "tr>td", text: "Source".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
