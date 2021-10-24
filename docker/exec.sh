if docker ps | grep -o quizzes-app-1 ; then
  docker exec -it quizzes-app-1 bash
else
  echo "run ./docker/start_app.sh first"
fi
