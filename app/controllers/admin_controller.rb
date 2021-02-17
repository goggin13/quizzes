class AdminController < ApplicationController
  def index
    question_ids = UserAnswer.all.map(&:question_id)
    @answered_question_counts = question_ids
      .group_by{ |i| i }
      .map{ |k,v| [k, v.count] }
      .reject { |k,v| v < 2 }
    @missed_questions = MissedQuestionsQuery.new.results
  end
end
