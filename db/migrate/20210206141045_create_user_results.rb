class CreateUserResults < ActiveRecord::Migration[6.1]
  def change
    create_table :user_results do |t|
      t.references :exam, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.boolean :correct

      t.timestamps
    end
  end
end
