require 'rails_helper'

RSpec.describe "Publics", type: :feature do
  before do
    @exam = FactoryBot.create(:exam, open: true)
    @question = FactoryBot.create(:question, exam: @exam)
    @answer_A = FactoryBot.create(:answer, question: @question, correct: true)
    @answer_B = FactoryBot.create(:answer, question: @question, correct: false)
    @answer_C = FactoryBot.create(:answer, question: @question, correct: false)
  end

  context "new user" do
    it "creates a new random user" do
      expect do
        visit "/public/index"
      end.to change(User, :count).by(1)
    end

    it "assigns a new username to the new user" do
      visit "/public/index"
      new_user = User.last
      expect(new_user.username).to start_with("Anonynurse")
    end

    it "signs that user in" do
      visit "/public/index"
      new_user = User.last
      expect(page).to have_content(new_user.username)
      expect(page).to have_link("Logout")
    end

    it "does not create another new user on subsequent visits" do
      expect do
        visit "/public/index"
        visit "/public/index"
      end.to change(User, :count).by(1)
    end
  end

  describe "index" do
    context "with an open exam" do
      it "shows a link to start practicing" do
        visit '/'
        expect(page).to have_link(@exam.title, href: "/public/practice/#{@question.id}")
      end
    end

    context "with no open exam" do
      xit "renders a welcome page"
    end
  end

  describe "practice" do
    it "renders the first question" do
      visit "/public/practice/#{@question.id}"
      expect(page).to have_content(@exam.title)
      expect(page).to have_content(@question.prompt)
      expect(page).to have_content(@answer_A.prompt)
      expect(page).to have_content(@answer_B.prompt)
      expect(page).to have_content(@answer_C.prompt)
      expect(page).to have_content(@question.explanation)
    end
  end
end
