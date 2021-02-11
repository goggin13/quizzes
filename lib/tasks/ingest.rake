require "open-uri"
require "cgi"

namespace :ingest do
  desc "Create a new exzm"
  task :new_exam  => :environment do
    exam_name = ENV["EXAM_NAME"]
    open = !Rails.env.production?
    puts "Creating : '#{exam_name}'"
    puts Exam.create!(
      title: exam_name,
      open: open
    )
  end

  desc "Ingest a local file of questions"
  task :local_file  => :environment do
    local_file_path = ENV["LOCAL_FILE_PATH"]
    puts "Ingesting : '#{local_file_path}'"
    QuestionService.ingest(local_file_path)
  end

  desc "Ingest a remote file of questions"
  task :remote_file  => :environment do
    remote_file_url = ENV["REMOTE_FILE_URL"]
    puts "Downloading : '#{remote_file_url}'"

    download = open(remote_file_url)
    local_file_path = CGI.unescape("#{download.base_uri.to_s.split('/')[-1]}")
    puts "Copying '#{remote_file_url}' -> #{local_file_path}"
    IO.copy_stream(download, local_file_path)

    puts "Ingesting : '#{local_file_path}'"
    puts Exam.all.collect(&:title)
    QuestionService.ingest(local_file_path)
  end
end
