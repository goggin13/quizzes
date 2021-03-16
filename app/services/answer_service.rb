class AnswerService
  def initialize(user)
    @user = user
  end

  def record_answers(question, answer_ids)
    answer_ids = [] if answer_ids.nil?

    answers = answer_ids.map { |answer_id| Answer.find(answer_id) }

    answers.each do |answer|
      UserAnswer.find_or_create_by!(user: @user, question: question, answer: answer)
    end

    user_result = UserResult.find_or_create_by!(
      exam: question.exam,
      user: @user,
      question: question,
    )
    user_result.correct = question.correct_answers?(answers)
    user_result.save!

    user_result
  end
end
