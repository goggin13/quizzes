require 'rails_helper'

RSpec.describe "answers/index", type: :view do
  before(:each) do
    assign(:answers, [
      FactoryBot.create(:answer),
      FactoryBot.create(:answer)
    ])
  end

  it "renders a list of answers" do
    render
    assert_select "tr>td", text: "MyString".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
