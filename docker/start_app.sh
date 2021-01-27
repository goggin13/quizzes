source docker/common.sh

docker run \
  -it \
  --env PORT=5000 \
  -p 5000:5000 \
  --name quizzes-web \
  -v $LOCAL_VOLUME_PATH:/var/www/quizzes \
  --rm \
  goggin13/quizzes
