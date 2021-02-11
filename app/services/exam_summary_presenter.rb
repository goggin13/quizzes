class ExamSummaryPresenter
  attr_reader :exam, :user

  def initialize(exam, user)
    @exam = exam
    @user = user
  end

  def rows
    presenter_rows = []
    presenter_row = Row.new
    ActiveRecord::Base.connection.execute(query).each do |result_row|
      if result_row["question_id"] != presenter_row.question_id
        presenter_row = Row.new
        presenter_row.question_id = result_row["question_id"]
        presenter_row.question_prompt = result_row["question_prompt"]
        presenter_row.answered_by_count = question_answered_by_counts[presenter_row.question_id]
        presenter_rows << presenter_row
      end

      answer = Answer.new
      answer.prompt = result_row["answer_prompt"]
      answer.user_selected = !result_row["user_selected"].blank?
      answer.correct = (result_row["correct"] == 1)
      answer.selected_by_count = answer_selected_counts[result_row["answer_id"]] || 0
      presenter_row.add_answer(answer)
    end

    presenter_rows
  end

  def query
    query = <<-SQL
      SELECT
        Q.id as question_id,
        A.id as answer_id,
        Q.prompt as question_prompt,
        A.prompt as answer_prompt,
        UA.id as user_selected,
        A.correct
      FROM questions Q
      INNER JOIN answers A ON
        A.question_id = Q.id
      LEFT JOIN user_answers UA ON
        UA.answer_id = A.id
        AND UA.user_id = :user_id
      WHERE Q.exam_id = :exam_id
    SQL

    Exam.sanitize_sql_for_assignment([query, {exam_id: @exam.id, user_id: @user.id}])
  end

  def question_answered_by_counts
    return @_question_answered_by_counts if defined?(@_question_answered_by_counts)

    raw_query = <<-SQL
      SELECT
        UR.question_id as question_id,
        count(*) as count
      FROM user_results UR
      WHERE UR.exam_id = :exam_id
      GROUP BY 1
    SQL

    query = Exam.sanitize_sql_for_assignment([raw_query, {exam_id: @exam.id}])
    @_question_answered_by_counts = ActiveRecord::Base.connection.execute(query).inject({}) do |acc, row|
      acc[row["question_id"]] = row["count"]

      acc
    end

    @_question_answered_by_counts
  end

  def answer_selected_counts
    return @_answer_selected_counts if defined?(@_answer_selected_counts)

    query = <<-SQL
      SELECT
        UA.answer_id as answer_id,
        count(*) as count
      FROM user_answers UA
      GROUP BY 1
    SQL

    @_answer_selected_counts = ActiveRecord::Base.connection.execute(query).inject({}) do |acc, row|
      acc[row["answer_id"]] = row["count"]

      acc
    end

    @_answer_selected_counts
  end

  class Row
    attr_accessor :question_prompt,
                  :question_id,
                  :answers,
                  :answered_by_count

    def initialize
      @answers = []
    end

    def add_answer(answer)
      answer.selected_by_percentage = answer.selected_by_count / answered_by_count.to_f
      answers << answer
    end
  end

  class Answer
    attr_accessor :prompt,
                  :user_selected,
                  :correct,
                  :selected_by_count,
                  :selected_by_percentage
  end
end
