ToDo

add explanation to summary page
summary page with link back to training grounds.
  label training grounds as such?

>>>>> pharm exam release

maybe?
* ingest source
* query optimizing
* large queries for practice index page
* test ingestion; decouple file name and test title
  * prompts on ingest task
* save your account prompt
* display chemical notation nicely

later
* Refactor ExamSummaryPresenter
  * Query objects for each query
* email on 500s
* JS testing for practice question interactions
  * cypress
* PGBackups
* assets resized and to S3
* remove from bucket after uploaded
* background job to clean up unused users
* show source somewhere?

maybe not?
* leaderboard

X exam summary page with question stats
X ingest double digit question prompts
X ingest pharm style questions
X new relic (free)
X upgrade postgres plan
X don't upload duplicate questions
X record users score
X procfile
X fix answer flashing on advancing question
X don't crash home page when there is an exam with no questions
X deploy to heroku
X script to upload questions to heroku
X display/handle multiple answer questions
X thorough tests around practice view
X troubleshoot font
X show landing page with no open exams (or multiple open exams?)
X unregister click listeners after submitting answer
 
Public pages
/
/practice/question_id

```
./docker/build_and_tag.sh
./docker/exec.sh
bundle exec rake db:test:prepare
```

## helpful
```

<%
sql="
SELECT user_id, 
       count(*) as total, 
       sum(case when correct then 1 else 0 end) as correct
FROM user_results
GROUP BY user_id
ORDER BY count(*) DESC;"

ActiveRecord::Base.connection.execute(sql).each { |r| puts r }

sql=" 
SELECT question_id,
       count(*) as total
FROM user_results
WHERE not correct
GROUP BY question_id
ORDER by count(*) DESC
LIMIT 20;" 
ActiveRecord::Base.connection.execute(sql).each { |r| puts Question.find(r["question_id"]); puts "*" * 80; puts "\n" }
%>
```
