class AddColumnToMemo < ActiveRecord::Migration[6.1]
  def change
    add_column :memos, :public_status, :integer, default: 0, null: false
    add_index :memos, :public_status
  end
end
