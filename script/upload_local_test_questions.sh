#!/usr/local/bin/ruby
file_path = ARGV[0]
file_name = File.basename(file_path)

command = "cp '#{file_path}' ."
puts command
puts `#{command}`

rails_command = "bundle exec rake ingest:local_file"

args = [
  "--env RAILS_ENV=development",
  "--env LOCAL_FILE_PATH='#{file_name}'",
  "--env DEBUG=true",
  "-it quizzes-web",
  rails_command
]

command = "docker exec #{args.join(" ")}"
puts command
puts `#{command}`
command = "rm '#{file_name}'"
puts command
puts `#{command}`
