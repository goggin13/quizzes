ToDo

* fix answer flashing on advancing question
* troubleshoot font
* ingest pharm style questions
* show landing page with no open exams (or multiple open exams?)
* record users score
* save your account prompt
* thorough tests around practice view

* Users
 * has_many :user_question_answers
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


