class Exam < ApplicationRecord
  validates_presence_of :title
  has_many :questions, dependent: :destroy
  has_many :user_results, dependent: :destroy

  def completed_by_user_count
    raw_query = <<-SQL
      SELECT
        UR.user_id,
        count(*) as answered_questions
      FROM user_results UR
      WHERE UR.exam_id = :exam_id
      GROUP BY UR.user_id
    SQL

    query = Exam.sanitize_sql_for_assignment([raw_query, {exam_id: id}])

    question_count = questions.count
    ActiveRecord::Base.connection.execute(query).inject(0) do |acc, row|
      if row["answered_questions"] == question_count
        acc + 1
      else
        acc
      end
    end
  end
end
