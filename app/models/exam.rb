class Exam < ApplicationRecord
  validates_presence_of :title
  has_many :questions, dependent: :destroy

  def title_and_count
    "#{title} - (#{questions.count} questions)"
  end
end
