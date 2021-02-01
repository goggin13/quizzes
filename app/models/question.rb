class Question < ApplicationRecord
  belongs_to :exam
  has_many :answers, dependent: :destroy
  validates_presence_of :prompt
  validates_presence_of :source

  def to_s
    "#{prompt}:\n\t#{answers.map(&:to_s).join("\n\t")}"
  end

  def next_question
    exam.questions.where("id > ?", id).order(id: :asc).first
  end

  def correct_answers
    answers.where(correct: true)
  end

  def is_multi_select?
    correct_answers.count > 1
  end
end
