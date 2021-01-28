class Question < ApplicationRecord
  belongs_to :exam
  has_many :answers
  validates_presence_of :prompt
  validates_presence_of :source
end
