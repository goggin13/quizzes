class PublicController < ApplicationController
  skip_before_action :admin_only!
  before_action :_set_current_user

  def index
    @exams = Exam.joins(:questions).where(open: true).order("title DESC").uniq
  end

  def practice
    @question = Question.find(params[:question_id])
    @next_question = @question.next_question
    @remaining = @question.exam.questions.where("id > ?", @question.id).count
    @total = @question.exam.questions.count
    @index = @total - @remaining
    @answered = @question.answered?(current_user)
    @user = current_user
  end

  def answer
    @question = Question.find(params[:question_id])
    service = AnswerService.new(current_user)
    service.record_answers(@question, params[:answer_ids])

    render json: "{}"
  end

  def summary
    @exam = Exam.find(params[:exam_id])
    @presenter = ExamSummaryPresenter.new(@exam, current_user)
  end

  def test_500
    x = 2 / 0
    render json: "{}"
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

    Rails.logger.info "Current user id: #{current_user.id}"
  end
end
