class Question < ApplicationRecord
  belongs_to :exam
  has_many :user_answers, dependent: :destroy # must be before answers to accomodate foreign key constraints
  has_many :answers, dependent: :destroy
  validates_presence_of :prompt
  validates_presence_of :source
  validates_uniqueness_of :prompt

  def to_s
    "#{prompt}:\n\t#{answers.map(&:to_s).join("\n\t")}\n\t#{explanation}"
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

  def answered?(user)
    user_answers.where(user_id: user.id).count > 0
  end

  def correct_answers?(given_answers)
    correct_answers.map(&:id).sort == given_answers.map(&:id).sort
  end
end
