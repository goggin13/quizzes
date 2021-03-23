if docker ps | grep -o quizzes_app_1 ; then
  docker exec -it quizzes_app_1 bash
else
  echo "run ./docker/start_app.sh first"
fi
