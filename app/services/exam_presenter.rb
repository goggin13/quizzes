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
    link_to(link_text, practice_path)
  end

  def image_path
    if completed?
      "banners.png"
    elsif !started?
      "crossed_swords.png"
    else
      "catapult.png"
    end
  end

  def practice_path
    if completed?
      public_summary_path(exam_id: exam.id)
    elsif !started?
      public_practice_path(question_id: exam.questions.first!.id)
    else
      answered_question_ids = user_results.map(&:question_id)
      next_question = exam.questions.where.not(id: answered_question_ids).first!
      public_practice_path(question_id: next_question.id)
    end
  end

  def grade
    if completed?
      float = user_results.where(correct: true).count / question_count.to_f * 100
      percentage = number_to_percentage(float, precision: 0)
      "#{percentage}"
    end
  end

  def letter_grade
   raw_grade = user_results.where(correct: true).count / question_count.to_f * 100
   case raw_grade
     when 90..100
       "A"
     when 80..90
       "B"
     when 70..80
       "C"
     when 60..70
       "D"
     else
       "F"
		end
  end

	def user_completed_count
    return @_user_completed_count if defined?(@_user_completed_count)

    @_user_completed_count = user_results.count
  end

  def question_count
    return @_question_count if defined?(@_question_count)

    @_question_count = exam.questions.count
  end

  def percentage_completed
    raw_percentage = user_completed_count / question_count.to_f * 100

    number_to_percentage(raw_percentage, precision: 0)
  end

  def title
    exam.title.sub("(", "<br/>(").html_safe
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
