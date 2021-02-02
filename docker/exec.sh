source docker/common.sh

if docker ps | grep -o quizzes-web ; then
  docker exec -it quizzes-web bash
elif docker ps | grep -o quizzes-console ; then
  docker exec -it quizzes-console bash
else
  docker run \
    -it \
    --env PORT=5000 \
    --env RAILS_ENV=test \
    -p 5000:5000 \
    --name quizzes-console \
    -v $LOCAL_VOLUME_PATH:/var/www/quizzes \
    --rm \
    goggin13/quizzes \
    bash
fi
