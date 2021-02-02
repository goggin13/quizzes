#!/usr/local/bin/ruby
AWS_ACCESS_KEY_ID = File.read(".aws_access_key_id").chomp
AWS_SECRET_ACCESS_KEY = File.read(".aws_secret_access_key").chomp

file_path = ARGV[0]
file_name = File.basename(file_path)

command = "AWS_ACCESS_KEY_ID=#{AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=#{AWS_SECRET_ACCESS_KEY} aws s3 cp '#{file_path}' 's3://mydecidekick.com/#{file_name}' --acl public-read --cache-control no-cache"
puts command
puts `#{command}`

url = "https://s3.amazonaws.com/mydecidekick.com/#{file_name.gsub(' ', '+')}"
command = "RAILS_ENV=development DEBUG=true REMOTE_FILE_URL=#{url} bundle exec rake ingest:remote_file"
puts command
command = "heroku run rake ingest:remote_file REMOTE_FILE_URL=#{url} DEBUG=true"
puts command
