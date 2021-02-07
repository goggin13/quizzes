class Answer < ApplicationRecord
  belongs_to :question
  has_many :user_answers
  validates_presence_of :prompt

  def to_s
      " #{correct? ? "*" : " "} : #{self.prompt}"
  end

  def selected_by?(user)
    user_answers.where(user_id: user.id).count > 0
  end
end
