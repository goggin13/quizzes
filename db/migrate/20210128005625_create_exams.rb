class CreateExams < ActiveRecord::Migration[6.1]
  def change
    create_table :exams do |t|
      t.string :title
      t.boolean :open

      t.timestamps
    end
  end
end
