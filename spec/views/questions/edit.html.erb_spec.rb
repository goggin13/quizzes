require 'rails_helper'

RSpec.describe "questions/edit", type: :view do
  before(:each) do
    @question = assign(:question, FactoryBot.create(:question))
  end

  it "renders the edit question form" do
    render

    assert_select "form[action=?][method=?]", question_path(@question), "post" do

      assert_select "textarea[name=?]", "question[prompt]"

      assert_select "textarea[name=?]", "question[source]"

      assert_select "textarea[name=?]", "question[explanation]"
    end
  end
end
