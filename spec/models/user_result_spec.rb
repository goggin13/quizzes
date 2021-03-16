require 'rails_helper'

RSpec.describe UserResult, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @question = FactoryBot.create(:question)
  end

  it "raises an exception on a non-unique UserResult" do
    UserResult.create!(
      exam: @question.exam,
      user: @user,
      question: @question,
    )
    expect do
      UserResult.create!(
        exam: @question.exam,
        user: @user,
        question: @question,
      )
    end.to raise_exception(ActiveRecord::RecordNotUnique)
  end
end
