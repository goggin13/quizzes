require 'rails_helper'

RSpec.describe QuestionService do
  before do
    @exam = FactoryBot.create(:exam, title: "301 Exam 2")
  end

  describe "self.ingest" do
    it "creates a question from a file and assigns it to the given exam" do
      expect do
        QuestionService.ingest("spec/test_files/301 Exam 2-Yoost.txt")
      end.to change(@exam.questions, :count).by(1)
    end

    it "creates a question using the prompt from the file" do
      QuestionService.ingest("spec/test_files/301 Exam 2-Yoost.txt")
      question = @exam.questions.first!
      expect(question.prompt).to eq("What snack choice would be the best suggestion by the nurse for a patient on a renal diet?")
    end

    it "creates a question using the source from the file name" do
      QuestionService.ingest("spec/test_files/301 Exam 2-Yoost.txt")
      question = @exam.questions.first!
      expect(question.source).to eq("Yoost")
    end

    it "creates answers for the question" do
      QuestionService.ingest("spec/test_files/301 Exam 2-Yoost.txt")
      question = @exam.questions.first!
      expect(question.answers.count).to eq(4)
      expect(question.answers.map(&:prompt).sort).to eq([
        "Carrot sticks", "Peanut butter", "Bananas", "Diet cola"
      ].sort)
    end

    it "marks the first answer as correct" do
      QuestionService.ingest("spec/test_files/301 Exam 2-Yoost.txt")
      question = @exam.questions.first!
      correct_answer = question.answers.where(prompt: "Carrot sticks").first!
      incorrect_answers = question.answers.where.not(prompt: "Carrot sticks")
      expect(incorrect_answers.map(&:correct).uniq).to eq([false])
      expect(correct_answer.correct).to eq(true)
    end

    it "marks the first answer as correct if there are no letters" do
      QuestionService.ingest("spec/test_files/301 Exam 2-no letters.txt")
      question = @exam.questions.first!
      correct_answer = question.answers.where(prompt: "Metabolic acidosis").first!
      incorrect_answers = question.answers.where(prompt: [
        "Respiratory alkalosis",
        "Respiratory acidosis",
        "Metabolic alkalosis"
      ]).all
      expect(correct_answer.correct).to eq(true)
      expect(incorrect_answers.map(&:correct)).to eq([false, false, false])
    end

    it "marks multiple answers as correct if indicated" do
      QuestionService.ingest("spec/test_files/301 Exam 2-MultipleAnswers.txt")
      question = @exam.questions.first!
      correct_answers = question.answers.where(prompt: ["Peanuts", "Bananas"]).all
      incorrect_answers = question.answers.where(prompt: ["Carrots", "Cola"]).all
      expect(correct_answers.map(&:correct)).to eq([true, true])
      expect(incorrect_answers.map(&:correct)).to eq([false, false])
    end

    it "saves the explanation for the question" do
      QuestionService.ingest("spec/test_files/301 Exam 2-Yoost.txt")
      question = @exam.questions.first!
      expect(question.explanation).to eq("Carrot sticks are the best")
    end

    it "sets the explanation to nil if there is not one" do
      QuestionService.ingest("spec/test_files/301 Exam 2-NoExplanation.txt")
      question = @exam.questions.first!
      expect(question.explanation).to be_nil
    end

    it "ingests a multiline explanation" do
      QuestionService.ingest("spec/test_files/301 Exam 2-multiline-explanation.txt")
      question = @exam.questions.first!
      expected = "Metabolic acidosis. \n* Respiratory alkalosis...\n* Respiratory acidosis...\n* Metabolic alkalosis..."
      expect(question.explanation).to eq(expected)
    end

    it "strips a leading digit if there is one" do
      QuestionService.ingest("spec/test_files/301 Exam 2-LeadingDigits.txt")
      expect(@exam.questions.count).to eq(7)
      @exam.questions.each_with_index do |question, i|
        expect(question.prompt).to eq("What is love-#{i}?")
      end
    end

    it "consumes multiple questions" do
      QuestionService.ingest("spec/test_files/301 Exam 2-MultipleQuestions.txt")
      question = @exam.questions.first!
      expect(question.prompt).to eq("What snack choice would be the best suggestion by the nurse for a patient on a renal diet?")
      question = @exam.questions.last!
      expect(question.prompt).to eq("A second question")
    end

    it "raises an exception if the exam is not found" do
      expect do
        QuestionService.ingest("spec/test_files/not a real exam-badformatting.txt")
      end.to raise_exception(ActiveRecord::RecordNotFound)
    end

    it "does not choke on multiple new lines or leading or trailing newlines" do
      expect do
        QuestionService.ingest("spec/test_files/301 Exam 2-MultipleNewLines.txt")
      end.to change(@exam.questions, :count).by(2)
    end
  end
end
