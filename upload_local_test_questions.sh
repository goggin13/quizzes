#!/usr/local/bin/ruby
file_path = ARGV[0]
file_name = File.basename(file_path)

command = "cp '#{file_path}' ."
puts command
puts `#{command}`

command = "LOCAL_FILE_PATH='#{file_name}' bundle exec rake ingest:local_file RAILS_ENV=development DEBUG=true "
puts command
