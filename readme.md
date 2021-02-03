ToDo

* save your account prompt
* business metrics page - users, questions answered, etc
* test on phone
* error handling / monitoring / logging
* slack preview (better copy?)
* show source somewhere

>>> post 301 midterm MVP requirements

* display user results
* display chemical notation nicely
* leaderboard
* ingest pharm style questions
  * Multi-line explanations
  * no letters for choice, just first answer
* JS testing for practice question interactions
* don't upload duplicate questions
* assets resized and to S3

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

* UserQuestionAnswer
 * user_id
 * question_id
 * option_id
 

Public pages
/
/practice/question_id

```
./docker/build_and_tag.sh
./docker/exec.sh
bundle exec rake db:test:prepare
```


