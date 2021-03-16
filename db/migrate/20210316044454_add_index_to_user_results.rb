class AddIndexToUserResults < ActiveRecord::Migration[6.1]
  def change
    add_index :user_results, [:user_id, :question_id], unique: true
    add_index :user_answers, [:user_id, :answer_id], unique: true
  end
end
