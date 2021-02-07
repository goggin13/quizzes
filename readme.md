ToDo

* error handling / monitoring / logging
* ingest source

>>> post 301 midterm MVP requirements

fast follow
* ingest pharm style questions
  * Multi-line explanations
  * no letters for choice, just first answer
* use raw SQL on admin page
  * a much better business metrics page - users, questions answered, etc

maybe?
* query optimizing
* test ingestion; decouple file name and test title
  * prompts on ingest task
* save your account prompt
* display chemical notation nicely

later
* JS testing for practice question interactions
  * cypress
* PGBackups
* assets resized and to S3
* remove from bucket after uploaded
* background job to clean up unused users
* show source somewhere?

maybe not?
* leaderboard

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
sql=
<<-SQL
SELECT user_id, 
       count(*) as total, 
       sum(case when correct then 1 else 0 end) as correct
FROM user_results
GROUP BY user_id
ORDER BY count(*) DESC;
SQL
ActiveRecord::Base.connection.execute(sql).each { |r| puts r }

sql=
<<-SQL
SELECT question_id,
       count(*) as total
FROM user_results
WHERE not correct
GROUP BY question_id
ORDER by count(*) DESC
LIMIT 10;
SQL
ActiveRecord::Base.connection.execute(sql).each { |r| puts r }
%>
```
