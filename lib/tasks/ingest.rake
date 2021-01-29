namespace :ingest do
  desc "Ingest a local file of questions"
  task :local_file  => :environment do
    local_file_path = ENV["LOCAL_FILE_PATH"]
    puts "Ingesting : '#{local_file_path}'"
    QuestionService.ingest(local_file_path)
  end
end
