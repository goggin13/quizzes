require 'rails_helper'

RSpec.describe "answers/show", type: :view do
  before(:each) do
    @answer = assign(:answer, FactoryBot.create(:answer))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Prompt/)
    expect(rendered).to match(/false/)
  end
end
