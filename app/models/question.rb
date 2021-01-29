class Question < ApplicationRecord
  belongs_to :exam
  has_many :answers, dependent: :destroy
  validates_presence_of :prompt
  validates_presence_of :source

  def to_s
    "#{prompt}:\n\t#{answers.map(&:to_s).join("\n\t")}"
  end
end
