class PublicController < ApplicationController
  skip_before_action :admin_only!
  before_action :_set_current_user

  def index
    @exams = Exam.joins(:questions).where(open: true).uniq
  end

  def practice
    @question = Question.find(params[:question_id])
    @next_question = @question.next_question
    @remaining = @question.exam.questions.where("id > ?", @question.id).count
    @total = @question.exam.questions.count
    @index = @total - @remaining
  end

  def _set_current_user
    unless signed_in?
      password = SecureRandom.hex(4)
      user = User.create!(
        username: "Anonynurse #{password}",
        password: "p#{password}d",
        password_confirmation: "p#{password}d",
      )

      sign_in(:user, user)
    end
  end
end
