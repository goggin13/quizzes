class ExamPresenter
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::NumberHelper

  attr_reader :exam, :user

  def initialize(exam, user)
    @exam = exam
    @user = user
  end

  def prompt
    "#{exam_link} #{exam.title} ( #{question_count} )#{grade}".html_safe
  end

  def exam_link
    link_to(link_text, practice_url)
  end

  def practice_url
    if completed? || !started?
      public_practice_path(question_id: exam.questions.first!.id)
    else
      answered_question_ids = user_results.map(&:question_id)
      next_question = exam.questions.where.not(id: answered_question_ids).first!
      public_practice_path(question_id: next_question.id)
    end
  end

  def grade
    if completed?
      float = user_results.where(correct: true).count / exam.questions.count.to_f * 100
      percentage = number_to_percentage(float, precision: 0)
      " - #{percentage}"
    end
  end

  def question_count
    if started? && !completed?
      "#{user_results.count}/#{exam.questions.count} questions answered"
    else
      "#{exam.questions.count} questions"
    end
  end

  def link_text
    if completed?
      "Review"
    elsif started?
      "Continue"
    else
      "Begin"
    end
  end

  def started?
    user_results.count > 0
  end

  def completed?
    user_results.count == exam.questions.count
  end

  def user_results
    exam.user_results.where(user_id: user.id)
  end
end
