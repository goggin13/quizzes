#!/usr/local/bin/ruby
require "cgi"
AWS_ACCESS_KEY_ID = File.read(".aws_access_key_id").chomp
AWS_SECRET_ACCESS_KEY = File.read(".aws_secret_access_key").chomp

source_path = ARGV[0]

def upload_file(file_path)
  file_name = File.basename(file_path)
  s3_path = "s3://mydecidekick.com/#{file_name}"
  command = "AWS_ACCESS_KEY_ID=#{AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=#{AWS_SECRET_ACCESS_KEY} aws s3 cp '#{file_path}' '#{s3_path}' --acl public-read --cache-control no-cache"
  puts command
  puts `#{command}`

  url = "https://s3.amazonaws.com/mydecidekick.com/#{CGI.escape(file_name)}"
  command = "heroku run rake ingest:remote_file REMOTE_FILE_URL=#{url} DEBUG=true"
  puts command
  puts `#{command}`

  command = "AWS_ACCESS_KEY_ID=#{AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=#{AWS_SECRET_ACCESS_KEY} aws s3 rm '#{s3_path}'"
  puts command
  puts `#{command}`
end

if File.directory?(source_path)
  if source_path[-1] == "/"
    source_path = source_path[0..-2]
  end
  Dir.foreach(source_path) do |filename|
    next if filename == '.' || filename == '..' || filename == ".DS_Store"
    puts filename
    upload_file("#{source_path}/#{filename}")
  end
else
  upload_file(source_path)
end
