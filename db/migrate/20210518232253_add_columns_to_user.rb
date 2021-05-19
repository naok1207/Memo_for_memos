class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :access_token, :string, unique: true, null: false
    add_index :users, :access_token
  end
end
