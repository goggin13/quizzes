require 'rails_helper'

RSpec.describe "public/index.html.erb", type: :view do
  it "renders a welcome page" do
    render
    expect(rendered).to match(/Welcome/)
  end
end
