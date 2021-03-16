require 'rails_helper'

RSpec.describe UserAnswer, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @question = FactoryBot.create(:question)
    @answer = FactoryBot.create(:answer, question: @question)
  end

  it "raises an exception on a non-unique UserAnswer" do
    UserAnswer.create!(
      user: @user,
      question: @question,
      answer: @answer,
    )
    expect do
      UserAnswer.create!(
        user: @user,
        question: @question,
        answer: @answer,
      )
    end.to raise_exception(ActiveRecord::RecordNotUnique)
  end
end
