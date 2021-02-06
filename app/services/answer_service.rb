class AnswerService
  def initialize(user)
    @user = user
  end

  def record_answers(question, answer_ids)
    answers = answer_ids.map do |answer_id|
      answer = Answer.find(answer_id)
    end

    answers.each do |answer|
      UserAnswer.create!(user: @user, question: question, answer: answer)
    end

    UserResult.create!(
      exam: question.exam,
      user: @user,
      question: question,
      correct: question.correct_answers?(answers),
    )
  end
end
