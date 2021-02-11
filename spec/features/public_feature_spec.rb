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
        expect(page).to have_link("Begin", href: "/public/practice/#{@question.id}")
      end

      it "does not crash if there are no exams with questions" do
        @question.destroy
        visit '/'
        expect(page).to have_content("Continue your training below")
      end

      it "only shows one entry for an exam with multiple questions" do
        FactoryBot.create(:question, exam: @exam)
        visit '/'
        expect(page).to have_link("Begin", href: "/public/practice/#{@question.id}", count: 1)
      end
    end
  end

  describe "practice" do
    it "renders the first question" do
      visit "/public/practice/#{@question.id}"
      expect(page).to have_content(@question.prompt)
      expect(page).to have_content(@answer_A.prompt)
      expect(page).to have_content(@answer_B.prompt)
      expect(page).to have_content(@answer_C.prompt)
      expect(page).to have_content(@question.explanation)
    end

    it "displays a link to the next question" do
      next_question = FactoryBot.create(:question, exam: @exam)
      visit "/public/practice/#{@question.id}"
      expect(page).to have_link("Next", href: "/public/practice/#{next_question.id}")
    end

    it "reads the exam is completed if there is no next question" do
      visit "/public/practice/#{@question.id}"
      expect(page).to have_content("You did it")
    end

    describe "single choice question" do
      it "does not have a submit button" do
        expect(page).to_not have_button("Submit")
      end
    end

    describe "multi select question" do
      it "renders a submit button" do
        @answer_B.update_attribute(:correct, true)
        visit "/public/practice/#{@question.id}"
        expect(page).to have_button("Submit")
      end

      it "Adds multi select specific text" do
        @answer_B.update_attribute(:correct, true)
        visit "/public/practice/#{@question.id}"
        expect(page).to have_content("Select all that apply")
      end
    end
  end
end
