if [[ $1 == 'status' ]]; then
  heroku logs -n1500 --dyno router | grep -Eo 'status=\d\d\d' | sort | uniq -c
elif [[ $1 == 'app' ]]; then
  heroku logs -n1500 --source app
fi
