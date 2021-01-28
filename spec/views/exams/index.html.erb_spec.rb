require 'rails_helper'

RSpec.describe "exams/index", type: :view do
  before(:each) do
    @exams = (0..1).map { FactoryBot.create(:exam) }
    assign(:exams, @exams)
  end

  it "renders a list of exams" do
    render
    assert_select "tr>td", text: "MyString".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    expect(rendered).to match("href=\"/exams/#{@exams[0].id}/questions\"")
    expect(rendered).to match("href=\"/exams/#{@exams[1].id}/questions\"")
  end
end
