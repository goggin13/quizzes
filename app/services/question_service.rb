class QuestionService
  def initialize(exam, source)
    @exam = exam
    @source = source
  end

  def self.ingest(file_path)
    exam_name, source = File.basename(file_path).split("-")
    source = source.split(".")[0]
    exam = Exam.where(title: exam_name).first!

    new(exam, source).ingest(file_path)
  end

  def ingest(file_path)
    question_blobs = File.read(file_path)
      .split("\n\n")
      .map(&:strip)
      .reject(&:empty?)

    question_blobs.each do |question_blob|
      debug(ingest_question(question_blob))
    end
  end

  def ingest_question(question_blob)
    lines = question_blob.split("\n")
    prompt = parse_prompt(lines.shift)

    if lines.last =~ /explanation/i
      explanation = parse_explanation(lines.pop)
    end

    question = @exam.questions.create!(
      source: @source,
      prompt: prompt,
      explanation: explanation,
    )

    ingest_answers(question, lines)

    question
  end

  def parse_prompt(line)
    if line =~ /^\d\./
      line = line[2..-1].strip
    end

    line
  end

  def parse_explanation(line)
    line[line.index(":") + 1..-1].strip
  end

  def ingest_answers(question, lines)
    if multiple_answers?(lines[0])
      correct_answers = parse_multiple_correct_answers(lines[0])
      lines.shift
    else
      correct_answers = parse_correct_answer(lines[0])
    end

    lines.each do |line|
      letter = line[0]
      prompt = line[3..-1]
      correct = correct_answers.include?(letter)
      question.answers.create!(prompt: prompt, correct: correct)
    end
  end

  def parse_multiple_correct_answers(line)
    line[1..-2].split(",").map(&:strip)
  end

  def parse_correct_answer(line)
    line[0]
  end

  def multiple_answers?(line)
    line[0] == "["
  end

  def debug(message)
    if ENV["DEBUG"]
      puts message
    end
  end
end
