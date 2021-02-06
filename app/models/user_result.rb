class UserResult < ApplicationRecord
  belongs_to :exam
  belongs_to :user
  belongs_to :question
end
