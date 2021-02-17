class MissedQuestionsQuery
  def query
    <<-SQL
      SELECT question_id,
             UR.exam_id,
             prompt,
           sum(case when correct then 1 else 0 end) as correct,
           count(*) as total,
           (sum(case when correct then 1 else 0 end) / cast(count(*) as decimal)) as percentage_correct
      FROM user_results UR
      INNER JOIN exams e ON
        UR.exam_id = e.id AND e.open
      INNER JOIN questions Q ON
        UR.question_id = Q.id
      GROUP BY 1,2,3
      HAVING COUNT(*) > 2
      ORDER BY 6 ASC
      LIMIT 30;
    SQL
  end

  def results
    ActiveRecord::Base.connection.execute(query).each { |r| puts r }
  end
end

