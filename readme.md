ToDo

>>>>> 301 exam release, pharm exam release

fast follow
* email on 500s
* ingestion validation
  * it "raises an error if there is a multi select and not every answer is labeled"
* alert if question has high failure rate
* page with summary stats for questions with most misses

On Break
* display chemical notation nicely
* use PG locally
* admin page under test
* JS testing for practice question interactions
  * cypress
  * staging site for smoke tests
* question flagging
  * flag questions with high error rates
  * allow users to flag questions with a reason
  * view flagged questions and mark flags as reviewed
  * hide questions that have been flagged by users more than once
  * recieve an email on any new flagged question
* checkboxes to open/close exams
* query optimizing
* large queries for practice index page
  * presenter object
* PGBackups strategy
* assets resized and to S3
* Don't rely on decidekick bucket for S3
* Refactor ExamSummaryPresenter
  * Query objects for each query
* background job to clean up unused users
* show source somewhere?
* Support for images?
* graph of questions answered
* easy way to log in as admin
* upload a folder of questions
* when admin views a question, show edit links for all the prompts
* /questions/<id> shows answers with links to edit
* exam list formatting improvement.

maybe?
* ingest source
* test ingestion; decouple file name and test title
  * prompts on ingest task
* save your account prompt
* Question search

maybe not?
* recalculate UserResult on any UserAnswer change or Answer.correct change
* leaderboard

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
