json.extract! question, :id, :prompt, :source, :explanation, :exam_id, :created_at, :updated_at
json.url question_url(question, format: :json)
