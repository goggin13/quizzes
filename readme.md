ToDo

On Break
* checkboxes to open/close exams
* display chemical notation nicely
* JS testing for practice question interactions
  * cypress
  * staging site for smoke tests
  * deploy script, to staging, smoke tests, then prod
* debug cloudfront css
* documentation (whats out there to generate for rails)

* Don't rely on decidekick bucket for S3
* PGBackups strategy
* query optimizing
* large queries for practice index page
  * presenter object
* Refactor ExamSummaryPresenter
  * Query objects for each query
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

```
./docker/build_and_tag.sh
./docker/exec.sh
bundle exec rake db:test:prepare
```

## helpful
docker-compose up
docker-compose down
docker-compose exec app bundle exec rake db:setup db:migrate
docker exec -it quizzes-app-1 bash

# Setup
./docker/build_and_tag.sh
./docker/start_app.sh
docker exec -it quizzes-database-1 psql -U postgres
	CREATE USER knightshift;
	ALTER USER knightshift WITH SUPERUSER;
./docker/exec.sh
  bundle exec rake db:setup
  RAILS_ENV=test bundle exec rake db:test:prepare
  RAILS_ENV=test bundle exec rspec --fail-fast
