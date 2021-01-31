ToDo

* ingest pharm style questions
* show landing page with no open exams (or multiple open exams?)
* record users score

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


