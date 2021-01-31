class AddUsernameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string, null: false, unique: true
    change_column_null :users, :email, true
    remove_index :users, "email"
    add_index :users, :username, unique: true
  end
end
