class Answer < ApplicationRecord
  belongs_to :question
  validates_presence_of :prompt

  def to_s
    "#{self.correct.to_s.center(6, " ")} : #{self.prompt}"
  end
end
