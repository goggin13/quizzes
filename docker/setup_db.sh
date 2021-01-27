source docker/common.sh

docker exec \
  quizzes-web \
  bundle exec rake db:create

docker exec \
  quizzes-web \
  undle exec rake db:migrate
