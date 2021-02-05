require 'rails_helper'

RSpec.describe Question, type: :model do
  it "raises an exception on a non-unique prompt" do
    question = FactoryBot.create(:question)
    expect do
      FactoryBot.create(:question, prompt: question.prompt)
    end.to raise_exception(ActiveRecord::RecordInvalid)
  end
end
