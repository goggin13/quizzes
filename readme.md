ToDo

* Exam
  * Title
  * Open/Closed
  * has_many :questions
* Questions
  * prompt
  * source
  * explanation
  * belongs_to :exam
  * has_many :options
* Options
  * Text
  * correct
  * belongs_to :question
* Users
 * has_many :user_question_answers
* UserQuestionAnswer
 * user_id
 * question_id
 * option_id
 

Public pages
/exam/<id>/users/register/
/exam/<id>

```
./docker/build_and_tag.sh
./docker/exec.sh
bundle exec rake db:test:prepare
```

DePaul MENP
