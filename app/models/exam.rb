class Exam < ApplicationRecord
  validates_presence_of :title
  has_many :questions
end
