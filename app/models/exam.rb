class Exam < ApplicationRecord
  validates_presence_of :title
  has_many :questions, dependent: :destroy
  has_many :user_results, dependent: :destroy
end
