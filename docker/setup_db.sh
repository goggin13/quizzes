source docker/common.sh

docker exec \
  quizzes-web \
  bundle exec rake db:create
