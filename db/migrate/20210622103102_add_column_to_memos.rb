class AddColumnToMemos < ActiveRecord::Migration[6.1]
  def change
    add_column :memos, :status, :integer, default: 0, null: false
    add_index :memos, :status
  end
end
