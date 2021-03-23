ToDo

On Break
* checkboxes to open/close exams
* JS testing for practice question interactions
  * cypress
  * staging site for smoke tests
* /questions/<id> shows answers with links to edit
* when admin views a question, show edit links for all the prompts
* nicer text fields for editing questions
* PGBackups strategy
* assets resized and to S3
* Don't rely on decidekick bucket for S3
* query optimizing
* large queries for practice index page
  * presenter object
* Refactor ExamSummaryPresenter
  * Query objects for each query
* easy way to log in as admin
* display chemical notation nicely
* admin page under test

maybe?
* background job to clean up unused users
* test ingestion; decouple file name and test title
  * prompts on ingest task

maybe not?
* recalculate UserResult on any UserAnswer change or Answer.correct change
* leaderboard
* graph of questions answered
* question flagging
  * flag questions with high error rates
  * allow users to flag questions with a reason
  * view flagged questions and mark flags as reviewed
  * hide questions that have been flagged by users more than once
  * recieve an email on any new flagged question
* save your account prompt
* Question search
* show source somewhere?
* Support for images?

X exam list formatting improvement.
X ingestion validation
X use PG locally
x upload a folder of questions
X alert if question has high failure rate
X page with summary stats for questions with most misses
X email on 500s
X APM Alert Policy?
X - add explanation to summary page
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
docker-compose up
docker-compose down
docker-compose exec app bundle exec rake db:setup db:migrate
docker exec -it quizzes_database_1 psql -U postgres
	CREATE USER knightshift;
	ALTER USER knightshift WITH SUPERUSER;
docker exec -it quizzes_app_1 bash
