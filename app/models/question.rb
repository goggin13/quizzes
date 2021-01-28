class Question < ApplicationRecord
  belongs_to :exam
  validates_presence_of :prompt
  validates_presence_of :source
end
