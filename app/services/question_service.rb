class QuestionService
  def initialize(exam, source)
    @exam = exam
    @source = source
  end

  def self.ingest(file_path)
    exam_name, source = File.basename(file_path).split("-")
    source = source.split(".")[0]
    debug("exam: #{exam_name}")
    exam = Exam.find_or_create_by(title: exam_name)
    if !Rails.env.prodution?
      exam.open = true
      exam.save!
    end

    new(exam, source).ingest(file_path)
  end

  def ingest(file_path)
    question_blobs = File.read(file_path)
      .split("\n\n")
      .map(&:strip)
      .reject(&:empty?)

    question_blobs.each do |question_blob|
      self.class.debug(ingest_question(question_blob))
    end
  end

  def ingest_question(question_blob)
    line_blob, explanation = question_blob.split(/explanation:/i)
    lines = line_blob.split("\n")
    prompt = parse_prompt(lines.shift)

    question = @exam.questions.create!(
      source: @source,
      prompt: prompt,
      explanation: explanation.try(:strip),
    )

    ingest_answers(question, lines)

    question
  end

  def parse_prompt(line)
    if line =~ /^\d+[\.)]/
      end_of_label = (line =~ /[\.)]/) + 1
      line = line[end_of_label..-1].strip
    end

    line
  end

  def ingest_answers(question, lines)
    if multiple_answers?(lines[0])
      correct_answers = parse_multiple_correct_answers(lines[0])
      lines.shift
    else
      lines = ensure_leading_letters_present(lines)
      correct_answers = parse_correct_answer(lines[0])
    end

    lines.each do |line|
      letter = line[0]
      if !(line =~ /^\w[)\.]/)
        raise "Unlabeled Answer"
      end
      end_of_label = (line =~ /[)\.]/) + 1
      prompt = line[end_of_label..-1].strip
      correct = correct_answers.include?(letter)
      correct_answers.delete(letter)
      question.answers.create!(prompt: prompt.strip, correct: correct)
    end

    if correct_answers.length > 0
      raise "Extra Answers (#{correct_answers.join(",")})"
    end
  end

  def ensure_leading_letters_present(lines)
    lines.each_with_index.map do |line, index|
      if (line =~ /^\w[)\.]/).nil?
        if index == 0
          "X) #{line}"
        else
          "Z) #{line}"
        end
      else
        line
      end
    end
  end

  def parse_multiple_correct_answers(line)
    line[1..-2].split(",").map(&:strip)
  end

  def parse_correct_answer(line)
    [line[0]]
  end

  def multiple_answers?(line)
    line[0] == "["
  end

  def self.debug(message)
    if ENV["DEBUG"]
      puts message
    end
  end
end
